-module(perf_test_1).
-export([test_ets/1]).

test_ets(NumberOfElementsInTheTable) ->
  file:write_file("test_results.md", "| Number Of elements in the Table | Insertion Time [ms] | Memory Allocated [MB] |\n| --- | --- | --- |\n"),
  test_ets(5, NumberOfElementsInTheTable).

test_ets(NumberOfRepetitions, _) when NumberOfRepetitions == 0 -> io:format("All repetitions finished.\n");
test_ets(NumberOfRepetitions, NumberOfElementsInTheTable) when NumberOfRepetitions > 0 ->
  test_large_table(NumberOfElementsInTheTable),
  io:format(io_lib:fwrite("Finished repetition: ~p.\n", [NumberOfRepetitions])),
  test_ets(NumberOfRepetitions - 1, NumberOfElementsInTheTable).

test_large_table(NumberOfElementsInTheTable) ->
  TestTable = ets:new(largeTestTable, [set]),
  {TimeTaken, _} = timer:tc(fun() -> populate_test_table(TestTable, NumberOfElementsInTheTable) end),

  io:format("Sample tuple:~n"),
  io:format("\t- ~p.~n", [create_test_tuple(456)]),

  io:format("Table allocation time:~n"),
  io:format("\t- ~p microseconds.~n", [TimeTaken]),
  io:format("\t- ~.2fms.~n", [translate_microseconds_to_milliseconds(TimeTaken)]),
  io:format("\t- ~.2fs.~n", [translate_microseconds_to_seconds(TimeTaken)]),

  io:format("Number of table elements:~n"),
  io:format("\t- ~p.~n", [ets:info(TestTable, size)]),

  io:format("Memory allocated:~n"),
  io:format("\t- ~p words.~n", [ets:info(TestTable, memory)]),
  io:format("\t- ~pB.~n", [translate_words_to_bytes(ets:info(TestTable, memory))]),
  io:format("\t- ~.2fKB.~n", [translate_words_to_kilobytes(ets:info(TestTable, memory))]),
  io:format("\t- ~.2fMB.~n", [translate_words_to_megabytes(ets:info(TestTable, memory))]),
  io:format("\t- ~.2fGB.~n", [translate_words_to_gigabytes(ets:info(TestTable, memory))]),

  file:write_file(
    "test_results.md",
    io_lib:fwrite(
      "| ~p | ~p | ~p |\n",
      [ets:info(TestTable, size),
      translate_microseconds_to_milliseconds(TimeTaken),
      translate_words_to_megabytes(ets:info(TestTable, memory))]),
    [append]),

  ets:delete(TestTable),

  io:format("Test finished.~n").

populate_test_table(TestTable, MaxNumberOfItems) when MaxNumberOfItems == 0 -> TestTable;
populate_test_table(TestTable, MaxNumberOfItems) when MaxNumberOfItems > 0 ->
    TestTuple = create_test_tuple(MaxNumberOfItems),
    ets:insert(TestTable, TestTuple),
    populate_test_table(TestTable, MaxNumberOfItems - 1).

create_test_tuple(Index) ->
  {
    Index,
    io_lib:format("~p", [Index]),
    io_lib:format("~p", [Index]),
    io_lib:format("~p", [Index]),
    io_lib:format("~p", [Index]),
    io_lib:format("~p", [Index])
  }.

translate_words_to_bytes(Words) -> Words * 8.
translate_words_to_kilobytes(Words) -> translate_words_to_bytes(Words) / 1000.
translate_words_to_megabytes(Words) -> translate_words_to_kilobytes(Words) / 1000.
translate_words_to_gigabytes(Words) -> translate_words_to_megabytes(Words) / 1000.

translate_microseconds_to_milliseconds(Microseconds) -> Microseconds / 1000.
translate_microseconds_to_seconds(Microseconds) -> translate_microseconds_to_milliseconds(Microseconds) / 1000.
