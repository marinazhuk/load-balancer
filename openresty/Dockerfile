FROM openresty/openresty:1.25.3.1-0-jammy

ARG GEOIP2_VERSION=3.4

RUN mkdir -p /var/lib/GeoIP/

RUN apt-get update \
    && apt-get install -y \
        build-essential \
        libpcre++-dev \
        zlib1g-dev \
        libssl-dev \
        libgeoip-dev \
        libmaxminddb-dev \
        mmdb-bin \
        wget \
        git


RUN cd /opt \
    && git clone --depth 1 -b $GEOIP2_VERSION --single-branch https://github.com/leev/ngx_http_geoip2_module.git \
    && wget -O - https://openresty.org/download/openresty-1.25.3.1.tar.gz | tar zxfv - \
    && mv /opt/openresty-1.25.3.1 /opt/openresty \
    && cd /opt/openresty \
    && ./configure --with-compat --add-dynamic-module=/opt/ngx_http_geoip2_module \
    && make \
    && make install