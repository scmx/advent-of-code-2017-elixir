defmodule Adventofcode.Day09StreamProcessingTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day09StreamProcessing

  describe "total_score/1" do
    test "{}, score of 1" do
      assert 1 = "{}" |> total_score()
    end

    test "{{{}}}, score of 1 + 2 + 3 = 6" do
      assert 6 = "{{{}}}" |> total_score()
    end

    test "{{},{}}, score of 1 + 2 + 2 = 5" do
      assert 5 = "{{},{}}" |> total_score()
    end

    test "{{{},{},{{}}}}, score of 1 + 2 + 3 + 3 + 3 + 4 = 16" do
      assert 16 = "{{{},{},{{}}}}" |> total_score()
    end

    test "{<a>,<a>,<a>,<a>}, score of 1" do
      assert 1 = "{<a>,<a>,<a>,<a>}" |> total_score()
    end

    test "{{<ab>},{<ab>},{<ab>},{<ab>}}, score of 1 + 2 + 2 + 2 + 2 = 9" do
      assert 9 = "{{<ab>},{<ab>},{<ab>},{<ab>}}" |> total_score()
    end

    test "{{<!!>},{<!!>},{<!!>},{<!!>}}, score of 1 + 2 + 2 + 2 + 2 = 9" do
      assert 9 = "{{<!!>},{<!!>},{<!!>},{<!!>}}" |> total_score()
    end

    test "{{<a!>},{<a!>},{<a!>},{<ab>}}, score of 1 + 2 = 3" do
      assert 3 = "{{<a!>},{<a!>},{<a!>},{<ab>}}" |> total_score()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_09_stream_processing.txt", fn input ->
        assert 14421 = input |> total_score()
      end)
    end
  end

  describe "garbage_score/1" do
    test "<>, 0 characters" do
      assert 0 = "<>" |> garbage_score()
    end

    test "<random characters>, 17 characters" do
      assert 17 = "<random characters>" |> garbage_score()
    end

    test "<<<<>, 3 characters" do
      assert 3 = "<<<<>" |> garbage_score()
    end

    test "<{!>}>, 2 characters" do
      assert 2 = "<{!>}>" |> garbage_score()
    end

    test "<!!>, 0 characters" do
      assert 0 = "<!!>" |> garbage_score()
    end

    test "<!!!>>, 0 characters" do
      assert 0 = "<!!!>>" |> garbage_score()
    end

    test ~s(<{o"i!a,<{i<a>, 10 characters) do
      assert 10 = ~s(<{o"i!a,<{i<a>) |> garbage_score()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_09_stream_processing.txt", fn input ->
        assert 6817 = input |> garbage_score()
      end)
    end
  end
end
