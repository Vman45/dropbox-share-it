#!/bin/bash -e

# Icons
ICON_WARNING=/usr/share/icons/gnome/48x48/status/messagebox_warning.png
ICON_OK=~/.dropbox-dist/images/emblems/emblem-dropbox-uptodate.png

if [ $# -eq 0 ]; then
  echo "Missing argument."
  exit 113
fi

# Configuration
CFG_FILE=~/.dropbox-share-it.cfg

case "$1" in

--configure|-c)

  echo "dropbox-share-it configuration"
  echo "------------------------------"
  echo ""

  read -p "Insert your Dropbox user id: " -e DROPBOX_UID

  echo DROPBOX_UID=$DROPBOX_UID > $CFG_FILE

  read -p "Insert Dropbox folder location [press enter for ~/Dropbox]: " -e REPLY1

  if [ -z "$REPLY1" ]; then
    DROPBOX_FOLDER=~/Dropbox
  else
    eval DROPBOX_FOLDER="${REPLY1%/}"
  fi

  if [ ! -d "$DROPBOX_FOLDER" ]; then
    echo "Inexistent Dropbox directory."
    echo "Aborting configuration. Bye."
    rm -f $CFG_FILE
    exit 113
  fi

  eval echo DROPBOX_FOLDER="$DROPBOX_FOLDER" >> $CFG_FILE

  read -p "Point to URL shortener [press enter for no url shortening]: " -e URL_SHORTENER

  eval echo URL_SHORTENER="$URL_SHORTENER" >> $CFG_FILE

  read -p "Enable directory handling [press enter for yes?] (y/n): " -e REPLY2

  case "$REPLY2" in
  n|N)
    HANDLE_DIRECTORIES=NO
  ;;
  *)
    HANDLE_DIRECTORIES=YES
  ;;
  esac

  echo HANDLE_DIRECTORIES="$HANDLE_DIRECTORIES" >> $CFG_FILE

  read -p "Set shared files expiration period in days [press enter for never]: " -e REPLY3

  if [ -z "$REPLY3" ]; then
    EXPIRATION_PERIOD=-1
  else
    EXPIRATION_PERIOD=$REPLY3
  fi

  echo EXPIRATION_PERIOD="$EXPIRATION_PERIOD" >> $CFG_FILE

  echo ""
  echo "Stored data:"
  echo "------------"

  cat $CFG_FILE

  exit 113

;;

--remove|-r)

  rm -f $CFG_FILE
  exit 113

;;

--help|-h)

  echo "dropbox-share-it script"
  echo ""
  echo "Git repository: https://github.com/rjdsc/dropbox-share-it"
  echo ""
  echo "Options:"

  echo "--configure, -c  : setup configuration file"
  echo "--remove, -r     : remove configuragion file"
  echo "--help, -h       : this screen"
  echo ""

  exit 113

;;

esac

if [ ! -e $CFG_FILE ]; then
  notify-send "Dropbox-Share-It!" \
              "Run configuration." \
              -i $ICON_WARNING
  exit 113
fi

if [ ! -d "$1" ] && [ ! -f "$1" ]; then

  notify-send "Dropbox-Share-It!" \
              "Invalid input." \
              -i $ICON_WARNING
  exit 113

fi

# Read configuration
source $CFG_FILE

# Create directory if inexistent
DROPBOX_SHARE="$DROPBOX_FOLDER"/Public/Share
mkdir -p $DROPBOX_SHARE

# Clean-up old shared files
if [ "$EXPIRATION_PERIOD" != "-1" ]; then
  find $DROPBOX_SHARE -type f -mtime +$EXPIRATION_PERIOD -print0 | xargs -0 rm -f
fi

# If there is no argument look at the clipboard
if [ -d "$1" ] && [ $HANDLE_DIRECTORIES != YES ]; then

  notify-send "Dropbox-Share-It!" \
              "Directories support disabled." \
              -i $ICON_WARNING
  exit 113

fi

BASENAME=`basename "$1"`

# Get filename
if [ -d "$1" ]; then
  FILENAME=$BASENAME.zip
else
  FILENAME=$BASENAME
fi

# Display a warning if file is already published
if [ -e "$DROPBOX_SHARE/$FILENAME" ]; then

  notify-send "Dropbox-Share-It!" \
              "$FILENAME was overwritten." \
              -i $ICON_WARNING
fi

# (Zip directory or copy file) into Dropbox Public directory
if [ -d "$1" ]; then

  zip -r "$DROPBOX_SHARE/$FILENAME" "$BASENAME"

  notify-send "Dropbox-Share-It!" \
              "Zipping directory." \
              -i $ICON_WARNING
else

  # Copy file to public folder
  cp "$1" $DROPBOX_SHARE

fi

# Create URL (spaces are substituted to %20 to make it a valid URL)
#RAWURL="https://dl.dropbox.com/u/$DROPBOX_UID/Share/$FILENAME"
RAWURL="https://dl.dropboxusercontent.com/u/$DROPBOX_UID/Share/$FILENAME"

echo $RAWURL

URL=`echo "$RAWURL" | \
     sed -E 's/ /%20/g' | \
     sed -E 's/\[/%5B/g' | \
     sed -E 's/\]/%5D/g'`


echo $URL

if [ -z $URL_SHORTENER ]; then
  SHORTENED=$URL
else
  SHORTENED=`eval $URL_SHORTENER $URL`
fi

echo -n $SHORTENED | xclip -selection clipboard

notify-send "Dropbox-Share-It!" \
            "Short URL: $SHORTENED" \
            -i $ICON_OK
