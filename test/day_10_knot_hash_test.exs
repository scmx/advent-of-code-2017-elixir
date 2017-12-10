defmodule Adventofcode.Day10KnotHashTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day10KnotHash

  describe "first_two_sum/1" do
    test "for 3,4,1,5 the first two numbers in the list end up being 3 and 4" do
      assert 12 = "3,4,1,5" |> first_two_sum(5)
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_10_knot_hash.txt", fn input ->
        assert 5577 = input |> first_two_sum()
      end)
    end
  end

  describe "process/1" do
    @expected [
      # The first length, 3, selects ([0] 1 2) 3 4 (where parentheses indicate the sublist to be reversed).
      # After reversing that section (0 1 2 into 2 1 0), we get ([2] 1 0) 3 4.
      # Then, the current position moves forward by the length, 3, plus the skip size, 0: 2 1 0 [3] 4. Finally, the skip size increases to 1.
      " 2  1  0 [3] 4 ",
      # The second length, 4, selects a section which wraps: 2 1) 0 ([3] 4.
      # The sublist 3 4 2 1 is reversed to form 1 2 4 3: 4 3) 0 ([1] 2.
      # The current position moves forward by the length plus the skip size, a total of 5, causing it not to move because it wraps around: 4 3 0 [1] 2. The skip size increases to 2.
      " 4  3  0 [1] 2 ",
      # The third length, 1, selects a sublist of a single element, and so reversing it has no effect.
      # The current position moves forward by the length (1) plus the skip size (2): 4 [3] 0 1 2. The skip size increases to 3.
      " 4 [3] 0  1  2 ",
      # The fourth length, 5, selects every element starting with the second: 4) ([3] 0 1 2. Reversing this sublist (3 0 1 2 4 into 4 2 1 0 3) produces: 3) ([4] 2 1 0.
      # Finally, the current position moves forward by 8: 3 4 2 1 [0]. The skip size increases to 4.
      " 3  4  2  1 [0]"
    ]

    test "iterates as expected" do
      initial_state = "3,4,1,5" |> build_lengths |> new(5)

      # The list begins as [0] 1 2 3 4 (where square brackets indicate the current position).
      assert pretty(initial_state) == "[0] 1  2  3  4 "

      Enum.reduce(@expected, initial_state, fn expected, acc ->
        state = process(acc)
        assert pretty(state) == expected
        state
      end)
    end
  end

  describe "knot_hash/1" do
    test "the empty string becomes a2582a3a0e66e6e86e3812dcb672a272" do
      assert "a2582a3a0e66e6e86e3812dcb672a272" = "" |> knot_hash
    end

    test "AoC 2017 becomes 33efeb34ea91902bb2f59c9920caa6cd" do
      assert "33efeb34ea91902bb2f59c9920caa6cd" = "AoC 2017" |> knot_hash
    end

    test "1,2,3 becomes 3efbe78a8d82f29979031a4aa0b16a9d" do
      assert "3efbe78a8d82f29979031a4aa0b16a9d" = "1,2,3" |> knot_hash
    end

    test "1,2,4 becomes 63960835bcdc130f0b66d7ff4f6a5a8e" do
      assert "63960835bcdc130f0b66d7ff4f6a5a8e" = "1,2,4" |> knot_hash
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_10_knot_hash.txt", fn input ->
        assert "44f4befb0f303c0bafd085f97741d51d" = input |> knot_hash()
      end)
    end
  end
end
