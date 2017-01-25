-module(generic_server).
-behaviour(gen_server).
-export([init/1,
        code_change/3,
        handle_call/3,
        handle_cast/2,
        handle_info/2,
        terminate/2]).

init(Args) -> io:format("init(~p)", [Args]).

code_change(OldVersion, State, Extra) ->
  io:format("code_change(~p, ~p, ~p)", [OldVersion, State, Extra]).

handle_call(Request, From, State) ->
    io:format("handle_call(~p, ~p, ~p)", [Request, From, State]).

handle_cast(Request, State) ->
  io:format("handle_cast(~p, ~p)", [Request, State]).

handle_info(Info, State) ->
  io:format("handle_info(~p, ~p)", [Info, State]).

terminate(Reason, State) ->
  io:format("terminate(~p, ~p)", [Reason, State]).
