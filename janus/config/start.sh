#!/bin/bash

# enable admin api
sed -i -E 's/(admin_https?) *=.*/\1 = true/g' /opt/janus/etc/janus/janus.transport.http.jcfg;

# use stun server
sed -i -E 's/#stun_server *=.*/stun_server = stun.l.google.com/g' /opt/janus/etc/janus/janus.jcfg;
sed -i -E 's/#stun_port *=.*/stun_port = 19302/g' /opt/janus/etc/janus/janus.jcfg;

janus --nat-1-1=$DOCKER_IP;
