#!/bin/bash
if [ ! -e /app/firststart ];then
  if $INIT_TAG; then
    beet import -q -m /music
  else
    beet import -q -A -m /music
  fi
else
  beet import -q /input
fi
