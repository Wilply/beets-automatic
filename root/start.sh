#!/bin/bash

if [ ! -e /app/firststart ]; then
  echo "[INFO] First start, initilization"
  bash -c /app/files/init.sh
  touch /app/firststart
  if [ $? -eq 0 ]; then
    echo "[INFO] Initilization sucessful"
  else
    echo "[ERROR] Failed to initialize, exiting"
    exit 1
  fi
else
  echo "[INFO] Already initialized, skipping"
fi

echo "[INFO] Starting Beets"
echo "[INFO] Waiting for events"
while inotifywait -e CLOSE_WRITE -e CLOSE_NOWRITE -e MOVED_TO -e CREATE /input ; do
  echo "[INFO] Events Received, wait 10s"
  sleep 10
  echo "[INFO] Chown input files"
  chown -R abc:abc /input
  chmod -R 750 /input
  echo "[INFO] Import"
  echo "****************************************"
  su abc -c /app/files/beets_import.sh
  echo ""
  echo "****************************************"
  if $DEL_INPUT; then
    echo "[INFO] Cleaning input folder"
    rm -rf /input/*
  fi
  echo "[INFO] Waiting for events"
done
