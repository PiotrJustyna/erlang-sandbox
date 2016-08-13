-module(core_storage).
-export([make_a_set/0]).

make_a_set() ->
    Tab = ets:new(table, [set]),
    ets:insert(Tab, {1, "Piotr"}),
    ets:insert(Tab, {2, "Justyna"}),
    TableInfo = ets:info(Tab),
    ets:delete(Tab),
    TableInfo.
