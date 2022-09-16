# Rsyslog

## How to install

`apt-get install --yes rsyslog`

## Configuration file

- `/etc/rsyslog.conf` is the main configuration file.
- `/etc/rsyslog.d/*.conf` contains more configuration files.

## Explanation of cfg file

```cfg
# Load a module (UDP)
$ModLoad imudp
# Expose using interface that contains IP 127.0.0.1
$UDPServerAddress 127.0.0.1
# Expose on port 514 using UDP
$UDPServerRun 514

# <SYSLOG_FACILITY>.<PRIORITY>
local0.* /var/log/traffic.log
local0.notice /var/log/traffic-admin.log
```

## Severity level for HAProxy

| Severity Level | HAProxy logs |
| -------------- | ------------ |
| emerg   | Errors such as running out of OS file descriptors |
| alert   | Some rare cases where something unexpected has happened, such as being unable to cache a response |
| crit    | not used |
| err     | Errors such as being unable to parse a map file, being unable to pars the HAProxy configuration file, and when an operation on a stick table fails. |
| warning | Certain important, but non-critical, errors such as failing to set a request header or failing to connect to a DNS nameserver |
| notice  | Changes to a server’s state, such as being UP or DOWN or when a server is disabled. Other events at startup, such as starting proxies and loading modules are also included. Health check logging, if enabled, also uses this level |
| info    | TCP connection and HTTP request details and errors |
| debug   | You may write custom Lua code that logs debug messages |

## Internal temporary lab

Execute [test](./test.sh) and see what happens ;)

## References

- [Journal Fields](https://www.freedesktop.org/software/systemd/man/systemd.journal-fields.html#)
- [HAProxy logs](https://www.haproxy.com/documentation/hapee/1-8r1/onepage/#8)
- [UDP syslog](https://www.rsyslog.com/doc/v7-stable/tutorials/tls_cert_udp_relay.html)
- [UDP](https://rsyslog.readthedocs.io/en/latest/tutorials/tls_cert_udp_relay.html)
