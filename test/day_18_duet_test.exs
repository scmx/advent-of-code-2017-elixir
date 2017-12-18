defmodule Adventofcode.Day18DuetTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day18Duet

  describe "recovered_frequency_value/1" do
    @input """
    set a 1
    add a 2
    mul a a
    mod a 5
    snd a
    set a 0
    rcv a
    jgz a -1
    set a 1
    jgz a -2
    """
    test "recovers frequency of the last played sound" do
      assert 4 = @input |> recovered_frequency_value()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_18_duet.txt", fn input ->
        assert 3423 = input |> recovered_frequency_value()
      end)
    end
  end
end
