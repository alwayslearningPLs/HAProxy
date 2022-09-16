# Learning HAProxy

HAProxy is an open-source load balancer. HAProxy listens for incomming requests and then
forwards them to one of your servers.

HAProxy atcs as both a _reverse proxy_ and a _load balancer_ for TCP-conected applications.

A _reverse proxy_ sits in front of your server and accepts requets from clients on its behalf.

If you have more than one server to redirect TCP connections, then you need a _load balancer_.

## How does it work?

HAProxy uses a _single-threaded_, _event driven_ architecture to receive requests from clients and dispatch them quickly to backend servers.

It does not open a thread and wait for a server to respond. Instead, it moves on to do other work and returns when it receives a callback.
