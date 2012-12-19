dropbox-share-it
================

dropbox-share-it processes files or directories.

When handling files, it copies it to the Dropbox Public folder and generates a shortened public link. When handling a directory, it firstly zips it then copies the zip file to the Dropbox Public folder.

This script was intended to be used as a file browser script. It was tested under Caja, Nautilus, and Thunar.

In Caja, just copy it to:

~/.config/caja/scripts

In Nautilus, copy it to:

~/.gnome2/nautilus-scripts

It used the following variables that must be set: DROPBOX_FOLDER and DROPBOX_UID.

For example:

DROPBOX_FOLDER=~/Dropbox/Public

DROPBOX_UID=1234

This script requires googlit.sh.
