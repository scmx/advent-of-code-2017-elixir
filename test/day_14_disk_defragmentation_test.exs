defmodule Adventofcode.Day14DiskDefragmentationTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day14DiskDefragmentation

  describe "squares_count/1" do
    test "flqrgnkx across the entire 128x128 grid 8108 squares are used" do
      assert 8108 = "flqrgnkx" |> squares_count()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_14_disk_defragmentation.txt", fn input ->
        assert 8250 = input |> squares_count()
      end)
    end
  end

  describe "regions_count/1" do
    test "flqrgnkx across the entire 128x128 grid there are 1242 groups" do
      assert 1242 = "flqrgnkx" |> regions_count()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_14_disk_defragmentation.txt", fn input ->
        assert 1113 = input |> regions_count()
      end)
    end
  end
end
