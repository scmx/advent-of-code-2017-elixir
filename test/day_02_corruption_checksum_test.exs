defmodule Adventofcode.Day02CorruptionChecksumTest do
  use ExUnit.Case

  import Adventofcode.Day02CorruptionChecksum
  import Adventofcode.TestHelpers

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
end
