#!/bin/bash

for ((i=0; i < 50; i++)); do
  curl -ksf -X GET http://localhost:8080/ping > /dev/null
done

haproxy_ip=$(docker container inspect hello_haproxy_1 --format '{{ $net := index .NetworkSettings.Networks "server-net" }} {{ $net.IPAddress }}')

server1_hits=$(docker-compose logs | grep -c "server1_1 .* $haproxy_ip .* GET")
server2_hits=$(docker-compose logs | grep -c "server2_1 .* $haproxy_ip .* GET")

cat <<EOF > /dev/stdout
********************************
* hits on server1: $server1_hits
* hits on server2: $server2_hits
********************************
EOF

