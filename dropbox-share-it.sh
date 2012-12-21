#!/bin/bash -e

if [ $# -eq 0 ]; then
  echo "Missing argument."
  exit 113
fi

# Configuration
CFG_FILE=~/.dropbox-share-it.cfg

if [ ! -e $CFG_FILE ]; then

  echo "dropbox-share-it configuration"
  echo "------------------------------"
  echo ""

  read -p "Insert Dropbox user id: " -e DROPBOX_UID
  read -p "Insert Dropbox folder [press enter for default: ~/Dropbox]: " -e REPLY1
  read -p "Point to URL shortner [press enter for no url shortening]: " -e URL_SHORTENER

  if [ -z $REPLY1 ]; then
    DROPBOX_FOLDER=~/Dropbox
  else
    DROPBOX_FOLDER=${REPLY%/}
  fi

  if [ ! -d $REPLY ]; then
    echo "Inexistent directory."
    echo "Aborting. Bye."
    exit 113
  fi

  echo DROPBOX_UID=$DROPBOX_UID > $CFG_FILE
  echo DROPBOX_FOLDER=$DROPBOX_FOLDER >> $CFG_FILE
  echo URL_SHORTENER=$URL_SHORTENER >> $CFG_FILE

  echo ""
  echo "Stored data:"
  echo "------------"

  cat $CFG_FILE

else

  source $CFG_FILE

fi

# Icons
ICON_WARNING=/usr/share/icons/gnome/48x48/status/messagebox_warning.png
ICON_OK=~/.dropbox-dist/images/emblems/emblem-dropbox-uptodate.png

DROPBOX_SHARE=$DROPBOX_FOLDER/Public/Share

EXPIRATION_PERIOD=60
HANDLE_DIRECTORIES=YES

# Create directory if inexistent
mkdir -p $DROPBOX_SHARE

# Clean-up old shared files
find $DROPBOX_SHARE -type f -mtime +$EXPIRATION_PERIOD -print0 | xargs -0 rm -f

# If there is no argument look at the clipboard
if [ -d "$1" ] && [ $HANDLE_DIRECTORIES != YES ]; then

  notify-send "Dropbox-Share-It!" \
              "Warning: Directories support disabled." \
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
              "Warning: $FILENAME was overwritten." \
              -i $ICON_WARNING
fi

# Zip directory or copy file into Dropbox Public directory
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
RAWURL="https://dl.dropbox.com/u/$DROPBOX_UID/Share/$FILENAME"
URL=`echo "$RAWURL" | \
     sed -E 's/ /%20/g'`


echo $URL_SHORTENER

if [ -z $URL_SHORTENER ]; then
  SHORTENED=$URL
else
  SHORTENED=`$URL_SHORTENER $URL`
fi

echo $SHORTENED

echo -n $SHORTENED | xclip -selection clipboard

notify-send "Dropbox-Share-It!" \
            "Short URL: $SHORTENED" \
            -i $ICON_OK
