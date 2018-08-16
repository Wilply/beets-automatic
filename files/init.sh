#!/bin/bash

echo "[INFO] Creating group and user"
groupadd -g $PGID abc
useradd -u $PUID -g abc -G root -d /home/abc/ -M -N abc
# # #
echo "[INFO] Copying files and setting permissions"
cp /app/files/config.yaml /home/abc/.config/beets/
chown -R abc:abc /home/abc/ /input /musiclibrary /app
chmod -R 770 /home/abc/ /input /musiclibrary /app
if [ $DISCOGS_TOKEN != "none" ]; then
  echo "[INFO] Setting up Discogs"
  sed -i "s/DISCOGS_TOKEN/$DISCOGS_TOKEN/g" /home/abc/.config/beets/config.yaml
else
  echo "[INFO] DISCOGS_TOKEN not defined, skipping"
  sed -i "s/DISCOGS_TOKEN/d" /home/abc/.config/beets/config.yaml
  sed -i "s/discogs.//g" /home/abc/.config/beets/config.yaml
fi
if [ $MODE = "copy" ] || [ $MODE = "COPY" ]; then
  echo "[INFO] Setting copy mode"
  sed -i "s/move: yes/copy: yes/g" /home/abc/.config/beets/config.yaml
else
  echo "[INFO] Setting move mode"
fi
exit 0
