defmodule Adventofcode.Day17SpinlockTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day17Spinlock

  describe "value_after_last/1" do
    test "step 3 times per insert gives 638 after the last written value" do
      assert 638 = "3" |> value_after_last()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_17_spinlock.txt", fn input ->
        assert 1337 = input |> value_after_last()
      end)
    end
  end

  describe "step/1" do
    @expected [
      # 0 (1): the spinlock steps forward three times (0, 0, 0), and then
      # inserts the first value, 1, after it. 1 becomes the current position.
      {[0, 1], 1},

      # 0 (2) 1: the spinlock steps forward three times (0, 1, 0), and then
      # inserts the second value, 2, after it. 2 becomes the current position.
      {[0, 2, 1], 1},

      # 0  2 (3) 1: the spinlock steps forward three times (1, 0, 2), and then
      # inserts the third value, 3, after it. 3 becomes the current position.
      {[0, 2, 3, 1], 2},
      {[0, 2, 4, 3, 1], 2},
      {[0, 5, 2, 4, 3, 1], 1},
      {[0, 5, 2, 4, 3, 6, 1], 5},
      {[0, 5, 7, 2, 4, 3, 6, 1], 2},
      {[0, 5, 7, 2, 4, 3, 8, 6, 1], 6},
      {[0, 9, 5, 7, 2, 4, 3, 8, 6, 1], 1}
    ]
    test "steps as expected" do
      Enum.reduce(@expected, new(3, 2017), fn expected, acc ->
        state = step(acc)
        assert {state.circular_buffer, state.current_index} == expected
        state
      end)
    end
  end
end
