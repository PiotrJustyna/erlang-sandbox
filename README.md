# Erlang Sandbox

This is a sandbox repository I use to play with Erlang.

## Contents

* Hello World
* Geometry_1:
 * simple server process
* Geometry_2:
 * simple server process
 * handling unknown messages
 * send/wait wrapper (rpc)
* Generic Servers
 * name server
 * server1
* ETS:
 * Distilled core storage example
 * Trigrams
* RETS:
  * ETS via REST
  * Sample Hello World code for now: creates a table and returns its basic info as HTML. Not JSON yet.

In the latests examples I'm exploring ETS - Erlang's in-memory storage. Results of running ```core_storage```'s ```make_a_set```:

![](https://raw.githubusercontent.com/PiotrJustyna/erlang-sandbox/master/images/core_storage.png)
