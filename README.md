# Learning HAProxy

HAProxy is an open-source load balancer. HAProxy listens for incomming requests and then
forwards them to one of your servers.

HAProxy atcs as both a _reverse proxy_ and a _load balancer_ for TCP-conected applications.

A _reverse proxy_ sits in front of your server and accepts requets from clients on its behalf.

If you have more than one server to redirect TCP connections, then you need a _load balancer_.

## How does it work?

HAProxy uses a _single-threaded_, _event driven_ architecture to receive requests from clients and dispatch them quickly to backend servers.

It does not open a thread and wait for a server to respond. Instead, it moves on to do other work and returns when it receives a callback.

## Interesting locations

- `/usr/sbin/haproxy`: it is the binary
- `/usr/share/lintian/overrides`: Lintian is a *Debian* package checker. The file here overrides rules that would otherwise cause the HAProxy package to be flagged as having an error. (not found).
- `/usr/share/doc/haproxy`: Documentation for HAProxy (It is needed to install the package `haproxy-doc`).
- `/run/haproxy`: Contains a UNIX socket that HAProxy binds to during startup.
- `/var/lib/haproxy`: Contains data that HAProxy stores while running.
- `/etc/logrotate.d/haproxy`: Configures HAProxy to use logrotate, which manages how logs are compressed and rotated.
- `/etc/default/haproxy`: Contains a default file for HAProxy that can override aspects of how the service starts up.
- `/etc/haproxy`: Contains the HAProxy configuration file and a directory where HTTP error pages are defined.
- `/etc/init.d/haproxy`: Contains the initialization script for the HAProxy service.

`/usr/sbin/haproxy -v` to get the version of HAProxy

## Labs

- [Hello world](./hello)

## Reference

TODO

