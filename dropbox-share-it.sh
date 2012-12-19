#!/bin/bash -e

# Icons
ICON_WARNING=/usr/share/icons/gnome/48x48/status/messagebox_warning.png
ICON_OK=~/.dropbox-dist/images/emblems/emblem-dropbox-uptodate.png

# Dropbox settings
DROPBOX_FOLDER=~/Dropbox/Public
DROPBOX_UID=? ? ? ?

# Select your url shortener
URL_SHORTENER=/path/to/directory/googlit.sh

HANDLE_DIRECTORIES=YES

# If there is no argument look at the clipboard
if [ -d "$1" ] && [ $HANDLE_DIRECTORIES != YES ]; then

  notify-send "Dropbox-Share-It! by R J Cintra" \
              "Warning: Directories cannot be shared." \
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
if [ -e "$DROPBOX_FOLDER/$FILENAME" ]; then

  notify-send "Dropbox-Share-It!" \
              "Warning: $FILENAME was overwritten." \
              -i $ICON_WARNING
fi

# Zip directory or copy file into Dropbox Public directory
if [ -d "$1" ]; then

  zip -r "$DROPBOX_FOLDER/$FILENAME" "$BASENAME" 

  notify-send "Dropbox-Share-It!" \
              "Zipping directory." \
              -i $ICON_WARNING
else

  # Copy file to public folder
  cp "$1" $DROPBOX_FOLDER

fi

# Create URL (spaces are substituted to %20 to make it a valid URL)
RAWURL="https://dl.dropbox.com/u/$DROPBOX_UID/$FILENAME"
URL=`echo "$RAWURL" | \
     sed -E 's/ /%20/g'`

SHORTENED=`$URL_SHORTENER $URL`

echo -n $SHORTENED | xclip -selection clipboard

notify-send "Dropbox-Share-It!" \
            "Short URL: $SHORTENED" \
            -i $ICON_OK
