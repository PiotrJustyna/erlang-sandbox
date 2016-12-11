-module(myappmod).
-include("include/yaws_api.hrl").
-compile(export_all).

translate_words_to_bytes(Words) -> Words * 8.

make_a_set() ->
  Tab = ets:new(table, [set]),
  ets:insert(Tab, {1, "Piotr"}),
  ets:insert(Tab, {2, "Justyna"}),
  ets:insert(Tab, {3, "Writes"}),
  ets:insert(Tab, {4, "Erlang"}),
  TableInfo = io_lib:format(
    "{"
    "\"Elements\": \"~p\","
    "\"Memory\": \"~pB\""
    "}",
     [ets:info(Tab, size),
     translate_words_to_bytes(ets:info(Tab, memory))]),
  ets:delete(Tab),
  TableInfo.

return_json(Json) ->
  {
    content,
    "application/json; charset=iso-8859-1",
    Json
  }.

out(_) -> return_json(make_a_set()).
