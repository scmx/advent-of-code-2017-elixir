defmodule Adventofcode.Day23CoprocessorConflagrationTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day23CoprocessorConflagration

  describe "how_many_mul/1" do
    test "with_puzzle_input" do
      with_puzzle_input("input/day_23_coprocessor_conflagration.txt", fn input ->
        assert 9409 = input |> how_many_mul()
      end)
    end
  end
end
