#!/bin/sh

apk add curl bind-tools

dig secure.haproxy.myhouse

tries=0
while [[ $tries -lt 10 ]] && [[ $(curl --cacert /root/cert.pem https://secure.haproxy.myhouse:443/hello | grep -c "world") -ne 1 ]]; do
  tries=$(expr tries + 1);
  sleep 1s;
done

if [[ $tries -ge 10 ]]; then
  echo "It wasn't possible to connect to the server";
  exit 1
fi

echo "Connected to server after $tries"

curl --cacert /root/cert.pem https://secure.haproxy.myhouse:443/bye

curl --cacert /root/cert.pem https://secure.haproxy.myhouse:443/hello

