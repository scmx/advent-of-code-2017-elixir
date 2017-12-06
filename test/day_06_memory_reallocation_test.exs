defmodule Adventofcode.Day06MemoryReallocationTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day06MemoryReallocation

  describe "cycles_in_total_until_same/1" do
    test "0, 2, 7, and 0" do
      assert 5 = "0 2 7 0" |> cycles_in_total_until_same()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_06_memory_reallocation.txt", fn input ->
        assert 3156 = input |> cycles_in_total_until_same()
      end)
    end
  end

  describe "redistribute/1" do
    @expected_redistributions [
      # The banks start with 0, 2, 7, and 0 blocks. The third bank has the most blocks, so it is chosen for redistribution.
      "0 2 7 0",
      # Starting with the next bank (the fourth bank) and then continuing to the first bank, the second bank, and so on, the 7 blocks are spread out over the memory banks. The fourth, first, and second banks get two blocks each, and the third bank gets one back. The final result looks like this: 2 4 1 2.
      "2 4 1 2",
      # Next, the second bank is chosen because it contains the most blocks (four). Because there are four memory banks, each gets one block. The result is: 3 1 2 3.
      "3 1 2 3",
      # Now, there is a tie between the first and fourth memory banks, both of which have three blocks. The first bank wins the tie, and its three blocks are distributed evenly over the other three banks, leaving it with none: 0 2 3 4.
      "0 2 3 4",
      # The fourth bank is chosen, and its four blocks are distributed such that each of the four banks receives one: 1 3 4 1.
      "1 3 4 1",
      # The third bank is chosen, and the same thing happens: 2 4 1 2.
      "2 4 1 2"
    ]

    test "redistributes as expected" do
      [initial_input | redistributions] = @expected_redistributions

      initial_state = new(initial_input)

      Enum.reduce(redistributions, initial_state, fn expected, acc ->
        state = redistribute(acc)
        assert pretty(state) == expected
        state
      end)
    end
  end

  describe "spread_out/1" do
    test "spreads out between banks" do
      assert [2, 4, 1, 2] = [0, 2, 7, 0] |> spread_out()
      assert [3, 1, 2, 3] = [2, 4, 1, 2] |> spread_out()
    end
  end
end
