#!/bin/bash

echo "[INFO] Creating group and user"
groupadd -g $PGID abc
useradd -u $PUID -g abc -G root -d /home/abc/ -M -N abc
# # #
echo "[INFO] Copying files and setting permissions"
cp /app/files/config.yaml /home/abc/.config/beets/
chown -R abc:abc /home/abc/ /input /music /app
chmod -R 770 /home/abc/ /input /music /app
if [ $DISCOGS_TOKEN != "none" ]; then
  echo "[INFO] Setting up Discogs"
  sed -i "s/DISCOGS_TOKEN/$DISCOGS_TOKEN/g" /home/abc/.config/beets/config.yaml
else
  echo "[INFO] DISCOGS_TOKEN not defined, skipping"
  sed -i "s/user_token: DISCOGS_TOKEN//g" /home/abc/.config/beets/config.yaml
  sed -i -E "s/discogs:?//g" /home/abc/.config/beets/config.yaml
fi
if [ $MODE = "copy" ] || [ $MODE = "COPY" ]; then
  echo "[INFO] Setting copy mode"
  sed -i "s/move: yes/copy: yes/g" /home/abc/.config/beets/config.yaml
else
  echo "[INFO] Setting move mode"
fi
if $INIT_TAG; then
  echo "[INFO] Scanning and importing old library (tag)"
  echo "****************************************"
  echo ""
  su abc -c /app/files/beets_import.sh
  echo ""
  echo "****************************************"
else
  echo "[INFO] Scanning and Iimporting old library (no tag)"
  echo ""
  echo "****************************************"
  echo ""
  su abc -c /app/files/beets_import.sh
  echo ""
  echo "****************************************"
fi
exit 0
