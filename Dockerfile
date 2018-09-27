FROM alpine:3.8

ENV PROFTPD_VERSION 1.3.6rc2

# persistent / runtime deps
ENV PROFTPD_DEPS \
  g++ \
  gcc \
  libc-dev \
  make

RUN set -x \
    && apk add --no-cache --virtual .persistent-deps \
        ca-certificates \
        curl \
    && apk add --no-cache --virtual .build-deps \
        $PROFTPD_DEPS \
    && curl -fSL ftp://ftp.proftpd.org/distrib/source/proftpd-${PROFTPD_VERSION}.tar.gz -o proftpd.tgz \
    && tar -xf proftpd.tgz \
    && rm proftpd.tgz \
    && mkdir -p /usr/local \
    && mv proftpd-${PROFTPD_VERSION} /usr/local/proftpd \
    && sleep 1 \
    && cd /usr/local/proftpd \
    && sed -i 's/__mempcpy/mempcpy/g' lib/pr_fnmatch.c \
    && ./configure \
    && make -j $(getconf _NPROCESSORS_ONLN) \
    && cd /usr/local/proftpd && make install \
    && make clean \
    && apk del .build-deps

ENV PROFTPD_USER ftp
ENV PROFTPD_PASSWORD ftp

RUN mkdir /ftp
COPY ./proftpd.conf /usr/local/etc/proftpd.conf
COPY ./entrypoint.sh /entrypoint.sh

EXPOSE 20
EXPOSE 21
EXPOSE 60000-60100

CMD ["/bin/sh", "/entrypoint.sh"]
