FROM python:3.7-alpine
MAINTAINER Wilply

RUN apk add --no-cache \
    inotify-tools

RUN pip install --no-cache-dir beets
