# 0.95.4
FROM homeassistant/qemux86-64-homeassistant:0.95.4

RUN apk add --no-cache ipmitool net-snmp-tools \
&& pip3 install mysqlclient pymysql pykonkeio pyunifi==2.16

# remove default ffmpeg
apk del ffmpeg ffmpeg-libs

# build ffmpeg
ARG FFMPEG_VERSION=4.1.2
ARG PREFIX=/opt/ffmpeg
ARG LD_LIBRARY_PATH=/opt/ffmpeg/lib
ARG MAKEFLAGS="-j4"

# add ffmpeg folder
RUN mkdir /opt/ffmpeg

# FFmpeg build dependencies.
RUN apk add --update \
build-base \
coreutils \
freetype-dev \
gcc \
lame-dev \
libogg-dev \
libass \
libass-dev \
libvpx-dev \
libvorbis-dev \
libwebp-dev \
libtheora-dev \
opus-dev \
pkgconf \
pkgconfig \
rtmpdump-dev \
wget \
x264-dev \
x265-dev \
yasm git python make g++ avahi-compat-libdns_sd avahi-dev dbus iputils sudo nano

# Get fdk-aac from testing.
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
apk add --update fdk-aac-dev

# Get ffmpeg source.
RUN cd /tmp/ && \
wget http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz && \
tar zxf ffmpeg-${FFMPEG_VERSION}.tar.gz && rm ffmpeg-${FFMPEG_VERSION}.tar.gz

# Compile ffmpeg.
RUN cd /tmp/ffmpeg-${FFMPEG_VERSION} && \
./configure \
--enable-version3 \
--enable-gpl \
--enable-nonfree \
--enable-small \
--enable-libmp3lame \
--enable-libx264 \
--enable-libx265 \
--enable-libvpx \
--enable-libtheora \
--enable-libvorbis \
--enable-libopus \
--enable-libfdk-aac \
--enable-libass \
--enable-libwebp \
--enable-librtmp \
--enable-postproc \
--enable-avresample \
--enable-libfreetype \
--enable-openssl \
--disable-debug \
--disable-doc \
--disable-ffplay \
--extra-cflags="-I${PREFIX}/include" \
--extra-ldflags="-L${PREFIX}/lib" \
--extra-libs="-lpthread -lm" \
--prefix="${PREFIX}" && \
make -j8 && make install && make distclean

# Cleanup.
RUN rm -rf /var/cache/apk/* /tmp/*

ENV PATH=/opt/ffmpeg/bin:$PATH
