FROM alpine:3.9

ARG TIMEZONE=Asia/Shanghai
ARG UID=1000
ARG GUID=1000
ARG VERSION=0.96.5

ADD "https://raw.githubusercontent.com/home-assistant/home-assistant/${VERSION}/requirements_all.txt" /tmp

RUN apk add --no-cache --virtual=build-dependencies \
build-base \
linux-headers \
python3-dev \
tzdata \
git \
python3 \
freetype-dev \
g++ \
gcc \
make \
libjpeg-turbo-dev \
libpng-dev \
zlib-dev \
curl-dev \
bluez-dev \
libxrandr-dev \
libsodium-dev \
mariadb-connector-c-dev \
ca-certificates \
libffi-dev \
libressl-dev \
nmap \
iputils \
openssh-client \
python3 \
su-exec \
musl-dev \
alpine-sdk \
autoconf \
eudev-dev \
glib-dev \
jpeg-dev \
libffi-dev \
libressl-dev \
libxml2-dev \
libxslt-dev \
mariadb-dev \
pkgconfig \
zlib-dev \
curl \
ffmpeg && \
addgroup -g ${GUID} hass && \
adduser -h /config -D -G hass -s /bin/sh -u ${UID} hass && \
pip3 install --no-cache-dir --upgrade pip setuptools                    && \
pip3 install --no-cache-dir --upgrade mysqlclient                       && \
pip3 install --no-cache-dir --upgrade wheel                             && \
pip3 install --no-cache-dir --upgrade uvloop==0.12.2                    && \
pip3 install --no-cache-dir --upgrade cython                            && \
pip3 install --no-cache-dir --upgrade cchardet                          && \
pip3 install setuptools --upgrade && \
pip3 install --no-cache-dir psycopg2 tensorflow pycryptodome==3.6.0 pykonkeio &&\
cp "/usr/share/zoneinfo/${TIMEZONE}" /etc/localtime && echo "${TIMEZONE}" > /etc/timezone && \
pip3 install --no-cache-dir --retries 30 --timeout 60 -r /tmp/requirements_all.txt && \
pip3 install --no-cache-dir homeassistant=="${VERSION}" && \
apk del build-dependencies && \
rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

HEALTHCHECK --interval=30s --retries=3 CMD curl --fail http://localhost:8123/api/ || exit 1

VOLUME /config
EXPOSE 8123

WORKDIR /config
ENTRYPOINT ["hass", "--open-ui", "--config=/config"]
