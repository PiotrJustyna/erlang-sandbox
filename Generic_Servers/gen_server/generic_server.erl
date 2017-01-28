-module(generic_server).
-behaviour(gen_server).
-export([start_link/0,
        synchronous_hello/0,
        asynchronous_hello/0]).
-export([init/1,
        code_change/3,
        handle_call/3,
        handle_cast/2,
        handle_info/2,
        terminate/2]).

start_link() ->
  gen_server:start_link({local, generic_server}, generic_server, [], []).

synchronous_hello() ->
  gen_server:call(generic_server, synchronousHello).

asynchronous_hello() ->
  gen_server:cast(generic_server, asynchronousHello).

% gen_server ->

init(Args) ->
  io:format("Server initialized with arguments: \"~p\"", [Args]),
  State = [],
  { ok, State }.

code_change(_OldVersion, State, _Extra) ->
  NewState = State,
  { ok, NewState }.

handle_call(synchronousHello, _From, State) ->
  Reply = "synchronousHello handled",
  NewState = State,
  { reply, Reply, NewState}.

handle_cast(asynchronousHello, State) ->
  NewState = State,
  { noreply, NewState}.

handle_info(_Info, State) ->
  NewState = State,
  { noreply, NewState}.

terminate(_Reason, _State) ->
  io:format("Terminating. Return value ignored.").

% <- gen_server
