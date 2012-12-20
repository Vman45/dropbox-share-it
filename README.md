##dropbox-share-it

dropbox-share-it processes files or directories.

When handling a file, the script copies it to the Dropbox Public folder and generates a shortened public link in clipboard ready for a CTRL-V. When handling a directory, first it zips it then publishes the resulting archive.

This script is intended to work as a file manager script. But it should work fine as a command line tool too.

It was tested in a Linux Mint box for the following file managers: Caja, Nautilus, and Thunar.

## Installation

1. If using Caja or Nautilus, copy the script file to one of the following directories:

        ~/.config/caja/scripts
    
        ~/.gnome2/nautilus-scripts

   In Thunar, just go to Edit menu, and then configure Custom Actions.

2. Edit the script file and supply your Dropbox user id (see below how to find out your Dropbox user id) at the following variable:

        DROPBOX_UID
3. Edit the script file and supply your Dropbox Public directory (if not default) at the following variable:

        DROPBOX_FOLDER
4. Edit the script file and supply the path for your preferred url shortener at the following variable:

        URL_SHORTENER

## How to Use

1. Just right-click on any file and run the script.
2. Target file is copied to Dropbox Public folder.
3. Notifications may appear.
4. A short URL should be available at your clipboard ready for ctrl+v.

If the target object is a folder, then the script will zip it into an archive. Remaining actions (2-4) follow the same.

## URL Shortener

We suggest using googlit.sh: https://github.com/rjdsc/googlit

Actually this script was only tested with googlit.sh.

## Dropbox UID

To find your Dropbox UID, get a Dropbox public link, as for example:

    https://dl.dropbox.com/u/01234567/filename.txt

In this case, the Dropbox UID is 01234567.

## Warning

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
