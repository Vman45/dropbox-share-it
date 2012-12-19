dropbox-share-it
================

dropbox-share-it processes files or directories.

When handling files, it copies it to the Dropbox Public folder and generates a shortened public link in clipboard ready for a ctrl-v. When handling a directory, it firstly zips it then treats it as a file.

File browser script
===================

This script is intended to work as a file browser script. It was tested under Caja, Nautilus, and Thunar.

In Caja, just copy it to:

    ~/.config/caja/scripts

In Nautilus, copy it to:

    ~/.gnome2/nautilus-scripts

Remarks
=======

Don't forget to make it executable:

    $ chmod u+x dropbox-share-it

The following variables that must be set in the script:

    DROPBOX_FOLDER
    DROPBOX_UID
    URL_SHORTENER

This script requires googlit.sh: https://github.com/rjdsc/googlit
