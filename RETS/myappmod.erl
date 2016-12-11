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
    "Number of elements: ~p"
    "Memory allocated: ~pB",
    [ets:info(Tab, size),
    translate_words_to_bytes(ets:info(Tab, memory))]),
  ets:delete(Tab),
  TableInfo.

out(_) -> {ehtml, [make_a_set()]}.
