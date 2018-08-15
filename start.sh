#!/bin/sh

while  $(inotifywait -e create moved_to /le/fichier) ; do
  beets import
done
