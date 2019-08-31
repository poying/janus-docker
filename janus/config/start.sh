#!/bin/bash

# enable admin api
sed -i -E 's/(admin_https?) *=.*/\1 = true/g' /opt/janus/etc/janus/janus.transport.http.jcfg;

# use stun server
sed -i -E 's/#?stun_server *=.*/stun_server = "stun.l.google.com"/g' /opt/janus/etc/janus/janus.jcfg;
sed -i -E 's/#?stun_port *=.*/stun_port = 19302/g' /opt/janus/etc/janus/janus.jcfg;

# change rtp port range
sed -i -E "s/#?rtp_port_range *=.*/rtp_port_range = \"${MEDIA_RTP_PORT_RANGE}\"/g" /opt/janus/etc/janus/janus.jcfg;

# change admin secret
sed -i -E "s/#?admin_secret *=.*/admin_secret = \"${ADMIN_SECRET}\"/g" /opt/janus/etc/janus/janus.jcfg;

# enable token validation
sed -i -E "s/#?token_auth *=.*/token_auth = true/g" /opt/janus/etc/janus/janus.jcfg;

janus --nat-1-1=$DOCKER_IP;
