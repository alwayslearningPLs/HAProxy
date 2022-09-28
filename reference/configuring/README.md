# Configure HAProxy

## Environment variables

Env variables are interpreted only within double quotes. Variables are expanded during the configuration parsing.

If the variable contains a list of several values separated by spaces, it can be expanded as individual arguments by enclosing the variable with braces and appending the suffix `'[*]'`. eg: `${ARR_VAR[*]}`

It is also possible to specify a default value to use when the variable is not set, by appending that value after a dash `-` next to the variable name. eg: `${HOST-127.0.0.1}`

full example:

```cfg
bind "fd@${FD_APP1}"

log "${LOCAL_SYSLOG-127.0.0.1}:514" local0 notice

user "$HAPROXY_USER"
```

Some variables are defined by HAProxy, they can be used in the config file, or could be inherited by a program:

- `HAPROXY_LOCALPEER`: defined at the startup of the process which contains the name of the local peer.
- `HAPROXY_CFGFILES`: list of the configuration files loaded by HAProxy, separated by semicolons. Can be useful in the case you specified a directory.
- `HAPROXY_MWORKER`: In master-worker mode, this variable is set to 1.
- `HAPROXY_CLI`: Configured listeners addresses of the stats socket for every process, separated by semicolons.
- `HAPROXY_MASTER_CLI`: In master-worker mode, listeners addresses of the master CLI, separated by semicolons.

Current list of pseudovariables is:

- `.FILE`: the name of the configuration file currently being parsed
- `.LINE`: the line number of the config file currently being parsed, starting at one.
- `.SECTION`: the name of the section currently being parsed, or its type if the section doesn't have a name (eg. "global"), or an empty string before the first section.

## Conditional blocks

- `.if <condition>`
- `.elif <condition>`
- `.else`
- `.endif`

list of predicates:

- `defined(<name>)`: returns true if an environment variable exists, regardless of its contents.
- `feature(<name>)`: returns true if feature `<name>` is listed as present in the features list reported by "haproxy -vv" (which means a <name> appears after a '+')
- `streq(<str1>, <str2>)`: returns true if only if the two strings area equal
- `strneq(<str1>, <str2>)`: returns true if only if the two strings differ.
- `version_atleast(<ver>)`: returns true if the current haproxy version is at least as recent as `<ver>` otherwise false.
- `version_before(<ver>)`: returns true if the current haproxy version if strictly older than `<ver>` otherwise false.

```cfg
.if defined(HAPROXY_MWORKER)
  listen mwcli_px
    bind :1111
.endif
```

