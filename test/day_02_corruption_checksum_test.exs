defmodule Adventofcode.Day02CorruptionChecksumTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day02CorruptionChecksum

  describe "checksum/1" do
    # The first row's largest and smallest values are 9 and 1, and their difference is 8.
    # The second row's largest and smallest values are 7 and 3, and their difference is 4.
    # The third row's difference is 6.
    @input """
    5 1 9 5
    7 5 3
    2 4 6 8
    """
    test "the spreadsheet's checksum would be 8 + 4 + 6 = 18" do
      assert 18 = @input |> checksum()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_02_corruption_checksum.txt", fn input ->
        assert 47623 = input |> checksum()
      end)
    end
  end

  describe "division_checksum/1" do
    # In the first row, the only two numbers that evenly divide are 8 and 2; the result of this division is 4.
    # In the second row, the two numbers are 9 and 3; the result is 3.
    # In the third row, the result is 2.
    @input """
    5 9 2 8
    9 4 7 3
    3 8 6 5
    """
    test "the sum of the results would be 4 + 3 + 2 = 9" do
      assert 9 = @input |> division_checksum()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_02_corruption_checksum.txt", fn input ->
        assert 312 = input |> division_checksum()
      end)
    end
  end
end
