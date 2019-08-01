FROM alpine:3.9

WORKDIR /tmp
ARG VERSION=0.96.5

ADD "https://raw.githubusercontent.com/home-assistant/home-assistant/${VERSION}/requirements_all.txt" /tmp


RUN  adduser -s /bin/false -D -h /app -u 4900 homeassistant \
&& apk add --no-cache --virtual=build-dependencies \
curl \
findutils \
glib \
iputils \
openssh-client \
python3 \
su-exec \
alpine-sdk \
autoconf \
eudev-dev \
glib-dev \
jpeg-dev \
libffi-dev \
libressl-dev \
libxml2-dev \
libxslt-dev \
linux-headers \
mariadb-dev \
python3-dev \
pkgconfig \
zlib-dev \
ffmpeg \
&& python3 -m pip install --upgrade --no-cache-dir pip==19.2.1 \
&& python3 -m pip install pykonkeio mysqlclient \
&& python3 -m pip install homeassistant==$VERSION \
&& LIBRARY_PATH=/lib:/usr/lib /bin/sh -c "python3 -m pip install -r /tmp/requirements_all.txt" \
&& apk del --purge build-dependencies \
&& rm -rf /tmp/*

HEALTHCHECK --interval=30s --retries=3 CMD curl --fail http://localhost:8123/api/ || exit 1

VOLUME /config
EXPOSE 8123

WORKDIR /config

ENTRYPOINT ["hass", "--open-ui", "--config=/config"]

