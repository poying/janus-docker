FROM fedora:31

ENV JANUS_VERSION v0.7.3

RUN dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
        && dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

RUN dnf -y install \
        libmicrohttpd-devel jansson-devel openssl-devel \
        libsrtp-devel sofia-sip-devel glib2-devel opus-devel \
        libogg-devel libcurl-devel pkgconfig gengetopt \
        libconfig-devel libtool autoconf automake \
        libwebsockets-devel libnice-devel git-core \
        diffutils file make which ffmpeg-devel

RUN git clone https://github.com/sctplab/usrsctp \
        && cd usrsctp \
        && ./bootstrap \
        && ./configure enable_warnings_as_errors=no --prefix=/usr \
        && make \
        && make install

RUN git clone https://github.com/meetecho/janus-gateway.git \
        && cd janus-gateway \
        && git checkout $JANUS_VERSION

RUN cd janus-gateway \
        && sh autogen.sh \
        && ./configure --prefix=/opt/janus --disable-rabbitmq --disable-mqtt --disable-nanomsg --enable-post-processing \
        && make CFLAGS='-std=c99' \
        && make install \
        && make configs

ENV PATH "/opt/janus/bin:${PATH}"

EXPOSE 7088 8088 8188 8089

CMD janus --nat-1-1=${DOCKER_IP}
