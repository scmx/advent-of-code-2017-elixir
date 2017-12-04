defmodule Adventofcode.Day04PassphrasesTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day04Passphrases

  describe "valid_count/1" do
    test "aa bb cc dd ee is valid" do
      assert 1 = "aa bb cc dd ee" |> valid_count
    end

    test "aa bb cc dd aa is not valid - the word aa appears more than once" do
      assert 0 = "aa bb cc dd aa" |> valid_count
    end

    test "aa bb cc dd aaa is valid - aa and aaa count as different words" do
      assert 1 = "aa bb cc dd aaa" |> valid_count
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_04_passphrases.txt", fn input ->
        assert 451 = input |> valid_count()
      end)
    end
  end
end
