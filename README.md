##dropbox-share-it


dropbox-share-it processes files or directories.

When handling files, it copies it to the Dropbox Public folder and generates a shortened public link in clipboard ready for a ctrl-v. When handling a directory, first it zips it then publishes the resulting archive.

This script is intended to work as a file browser script. It was tested under Caja, Nautilus, and Thunar.

## How to Use

1. If using Caja or Nautilus, copy the script file to either of the following directories:

        ~/.config/caja/scripts
    
        ~/.gnome2/nautilus-scripts

2. Edit the script file and supply your Dropbox user id. 


## Dropbox UID

To find your Dropbox UID, get a Dropbox public link, as for example:
    https://dl.dropbox.com/u/01234567/filename.txt

In this case, the Dropbox UID is 01234567.

Remarks
=======

Don't forget to make it executable:

    $ chmod u+x dropbox-share-it

The following variables that must be set in the script:

    DROPBOX_FOLDER
    DROPBOX_UID
    URL_SHORTENER

This script requires googlit.sh: https://github.com/rjdsc/googlit

## Warning

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
