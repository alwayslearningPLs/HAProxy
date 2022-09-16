FROM ubuntu:22.04

RUN apt-get update --yes && apt-get install --yes software-properties-common && \
  add-apt-repository ppa:vbernat/haproxy-2.6 -y && \
  apt-get update --yes && apt-get install --yes file haproxy-doc haproxy=2.6.\* && \
  haproxy -v

CMD ["/usr/sbin/haproxy", "-f", "/etc/haproxy/haproxy.cfg"]

