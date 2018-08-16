FROM python:3.6.6-slim-stretch
# Error with python3.7
MAINTAINER Wilply

ENV DISCOGS_TOKEN="none"
ENV PUID=1001
ENV PGID=1001
ENV MODE="copy"
ENV DEL_INPUT="false"

RUN apt update && apt install -y \
    inotify-tools \
    libchromaprint1 \
    libchromaprint-tools \
    python3-acoustid \
    python3-gi \
    gstreamer1.0 \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly

RUN pip install --no-cache-dir --progress-bar off \
    pyacoustid \
    discogs-client \
    requests \
    beets


WORKDIR /app

RUN mkdir -p /input /musiclibrary /home/abc/.config/beets

COPY files/ /app/files
COPY start.sh /app/

RUN rm -rf /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

VOLUME /root/.config/beets/
VOLUME /app

CMD ["./start.sh"]
