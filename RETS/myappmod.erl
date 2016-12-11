-module(myappmod).
-include("include/yaws_api.hrl").
-compile(export_all).

box(Str) ->
    {'div',[{class,"box"}],
     {pre,[],Str}}.

translate_words_to_bytes(Words) -> Words * 8.

make_a_set() ->
  Tab = ets:new(table, [set]),
  ets:insert(Tab, {1, "Piotr"}),
  ets:insert(Tab, {2, "Justyna"}),
  hello = ets:info(Tab, size),
  TableInfo = io_lib:format("Number of elements hello: ~p~n", [7]),
  % TableInfo = io_lib:format("A#arg.appmoddata = ~p~n"
  %                   "A#arg.appmod_prepath = ~p~n"
  %                   "A#arg.querydata = ~p~n",
  %                   [ets:info(Tab, size),
  %                    ets:info(Tab, size),
  %                    ets:info(Tab, size)]),
  ets:delete(Tab),
  TableInfo.

out(_) ->
    {ehtml,
     [{p,[],
       box(make_a_set())}]}.
