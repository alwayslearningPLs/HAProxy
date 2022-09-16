#!/bin/bash

docker image build --file ./Dockerfile --tag rsyslog:test --no-cache .

docker container rm -f rsyslog

docker container run --rm --detach --name rsyslog \
  --cap-add SYSLOG \
  --publish 127.0.0.1:514:514/udp \
  --volume ${PWD}/rsyslog.conf:/etc/rsyslog.conf \
  --volume ${PWD}/var/log:/var/log rsyslog:test

docker container run --rm --detach \
  --log-driver syslog \
  --log-opt syslog-address=tcp://$(docker container inspect rsyslog --format "{{.NetworkSettings.Networks.bridge.IPAddress}}") \
  alpine:3.16 echo hello

docker container logs rsyslog | grep hello

# Cleanup
docker container rm -f rsyslog

