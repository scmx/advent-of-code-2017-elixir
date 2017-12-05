defmodule Adventofcode.Day05TwistyTrampolinesTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day05TwistyTrampolines

  describe "how_many_steps/1" do
    test "the exit is reached in 5 steps" do
      assert 5 = "0 3 0 1 -3" |> how_many_steps()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_05_twisty_trampolines.txt", fn input ->
        assert 342_669 = input |> how_many_steps()
      end)
    end
  end

  describe "iterate/1" do
    @expected_iterations [
      # before we have taken any steps.
      "(0) 3  0  1  -3 ",
      # jump with offset 0 (that is, don't jump at all). Fortunately, the instruction is then incremented to 1.
      "(1) 3  0  1  -3 ",
      # step forward because of the instruction we just modified. The first instruction is incremented again, now to 2.
      " 2 (3) 0  1  -3 ",
      # jump all the way to the end; leave a 4 behind.
      " 2  4  0  1 (-3)",
      # go back to where we just were; increment -3 to -2.
      " 2 (4) 0  1  -2 ",
      # jump 4 steps forward, escaping the maze.
      " 2  5  0  1  -2 "
    ]
    test "iterates as expected" do
      [first_input | iterations] = @expected_iterations

      Enum.reduce(iterations, first_input, fn expected, acc ->
        state = iterate(acc)
        assert pretty(state) == expected
        state
      end)
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_05_twisty_trampolines.txt", fn input ->
        assert 342_669 = input |> how_many_steps()
      end)
    end
  end
end
