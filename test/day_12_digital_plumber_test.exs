defmodule Adventofcode.Day12DigitalPlumberTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day12DigitalPlumber

  describe "how_many_programs/1" do
    @input """
    0 <-> 2
    1 <-> 1
    2 <-> 0, 3, 4
    3 <-> 2, 4
    4 <-> 2, 3, 6
    5 <-> 6
    6 <-> 4, 5
    """
    test "a total of 6 programs are in this group" do
      assert 6 = @input |> how_many_programs()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_12_digital_plumber.txt", fn input ->
        assert 145 = input |> how_many_programs()
      end)
    end
  end

  describe "which_programs/1" do
    # Program 0 by definition.
    # Program 2, directly connected to program 0.
    # Program 3 via program 2.
    # Program 4 via program 2.
    # Program 5 via programs 6, then 4, then 2.
    # Program 6 via programs 4, then 2.
    @input """
    0 <-> 2
    1 <-> 1
    2 <-> 0, 3, 4
    3 <-> 2, 4
    4 <-> 2, 3, 6
    5 <-> 6
    6 <-> 4, 5
    """
    test "returns expected programs/1" do
      assert [0, 2, 3, 4, 5, 6] = @input |> parse() |> which_programs()
    end
  end
end
