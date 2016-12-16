-module(myappmod).

-include("include/yaws_api.hrl").

-export([out/1]).

%%%===================================================================
%%% helpers
%%%===================================================================

return_json(Json) ->
  { content,
    "application/json; charset=iso-8859-1",
    Json }.

extract_method(Arg) ->
    Rec = Arg#arg.req,
    Rec#http_request.method.

%%%===================================================================
%%% storage
%%%===================================================================

create_storage() ->
  io_lib:format("~p", [ets:new(storage, [set, named_table])]).

get_number_of_storage_elements() ->
  io_lib:format("~p", [ets:info(storage, size)]).

add_storage_element() ->
  io_lib:format("~p", [ets:insert(storage, {1})]).

%%%===================================================================
%%% YAWS
%%%===================================================================

out(Arg) ->
  Method = extract_method(Arg),
  handle_yaws(Method, Arg).

%%%===================================================================
%%% HTTP handlers
%%%===================================================================

handle_yaws('PUT', _Arg) ->
  return_json(create_storage());

handle_yaws('POST', _Arg) ->
  return_json(add_storage_element());

handle_yaws('GET', _Arg) ->
  return_json(get_number_of_storage_elements());

handle_yaws(Method, _Arg) ->
  return_json(io:format("Unknown Method: ~p.", [Method])).
