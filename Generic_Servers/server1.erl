-module(server1).
-export([start/2, rpc/2]).

start(Name, Module) ->
  register(Name, spawn(
    fun() ->
      loop(Name, Module, Module:init())
    end)).

rpc(Name, Request) ->
  Name ! {self(), Request},
  receive
    {Name, Response} -> Response
  end.

loop(Name, Module, State) ->
  receive
    {From, Request} ->
      {Response, State1} = Module:handle(Request, State),
      From ! {Name, Response},
      loop(Name, Module, State1)
  end.
