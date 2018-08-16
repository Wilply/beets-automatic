# Beets Automatic

Beets is the media library management system for obsessive-compulsive music geeks. *From beets [official repo](https://github.com/beetbox/beets).*

This is a docker version which is fully automatic, it will scan the input folders untils it detect changes, the it will import the files from the input directory and process them then start again.  
It's one of my first docker image, any advise will be welcome.
Docker links: (https://hub.docker.com/r/wilply/beets-automatic/)

### How to use this image
##### Supported ENV variables
* DISCOGS_TOKEN ``` ``` The token for the [discogs API](https://www.discogs.com/developers/#). If not set, beets will not use discogs
* PGID ``` ``` User uid beets will run as. *Default 1001*
* PGID ``` ``` Same but for group gid. *Default 1001*
* MODE ``` ``` Either move or copy, set if you want your files to be copied or moved from the input folder. *Default "copy"*
* DEL_INPUT``` ``` If you want the files in your input folder to be deleted after import. *Default "false"*
##### Volumes
* /input ``` ``` Input folder, beets will scan and import from this folder
* /musiclibrary ``` ``` Output folder, where you files will be copied after beeing processes
* /home/abc/.config/beets ``` ``` Beets config files
##### Example
###### Minimal
```
docker run --name automatic-beets \
            -v /path/to/your/input/foler:/input/ \
<<<<<<< HEAD
            -v /path/to/your/music/library:/musiclibrary/music \
            -v /path/to/your/beetsmusic.db:/musiclibrary/beetsmusic.db
             Wilply/automatic-beets
=======
            -v /path/to/your/music/library:/musiclibrary/ \
             Wilply/beets-automatic
>>>>>>> 529935be2a42edceb09ea154a65299ac37aebecf
```
###### Complete
```
docker run --name automatic-beets \
            -e DISCOGS_TOKEN="your discogs token" \
            -e PGID=1001 \
            -e PUID=1001 \
            -e MODE="move" \
            -e DEL_INPUT="false" \
            -v /path/to/your/input/foler:/input/ \
            -v /path/to/your/music/library:/musiclibrary/music/ \
            -v /path/to/config:/home/abc/.config/beets/ \
<<<<<<< HEAD
            -v /path/to/your/beetsmusic.db:/musiclibrary/beetsmusic.db
             Wilply/automatic-beets
=======
             Wilply/beets-automatic
>>>>>>> 529935be2a42edceb09ea154a65299ac37aebecf
```
###### Compose
```
version: '3'

services:
  beets:
    image: Wilply/beets-automatic
    restart: always
    environment:
      - DISCOGS_TOKEN="your disogs api token"
      - PGID=1001
      - PUID=1001
      - MODE="copy"
      - DEL_INPUT="false"
    volumes:
      - /path/to/your/input/foler:/input/
      - /path/to/your/music/library:/musiclibrary/music/
      - /path/to/config:/home/abc/.config/beets/
      - /path/to/your/beetsmusic.db:/musiclibrary/beetsmusic.db
```
