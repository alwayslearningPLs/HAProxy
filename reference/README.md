# HTTP in HAProxy

When HAProxy is running in HTTP mode, both the request and the response are fully analyzed and indexed, thus it becomes possible to build matching criteria on almost anything found in the contents.

## HTTP transaction model

The HTTP protocol is _transaction-driven_. This means that each request will lead to one and only one response.

`[CON1] [REQ1] ... [RESP1] [CLO1] [CON2] [REQ2] .. [RESP2] [CLO2]`

In this mode, called the _HTTP close_ mode, there are as many connection establishments as there are HTTP transactions. Since the connection is closed by the server after the response, the client does not need to know the _Content-Length_.

We have also the _Keep alive_ mode, which is going to reuse connections between two subsequent transactions, so the client needs to know the _Content-Length_.

`[CON] [REQ1] ... [RESP1] [REQ2] ... [RESP2] [CLO] ...`

It is generally better than the close mode, but not always because the clients often limit their concurrent connections to a smaller value.

Another one is the _pipelining mode_, which still uses _keep alive_, but the client does not wait for the first response to send the second request. This is useful for fetching large numbers of images composing a page:

`[CON] [REQ1] [REQ2] ... [RESP1] [RESP2] [CLO] ...`

The next improvement is the _multiplexed mode_, as implemented in HTTP/2. This time, each transaction is assigned a single stream identifier, and all streams are multiplexed over an existing connection. Many requests can be sent in parallel by the client, and responses can arrive in any order since they also carry the stream identifier.

HAProxy supports 4 connection modes:

- _Keep alive_ (default): All requests and responses are processed.
- _tunnel_(deprecated)
- _server close_: The server-facing connection is closed after the response.
- _close_: The connection is actively closed after end of response.
