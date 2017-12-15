defmodule Adventofcode.Day15DuelingGeneratorsTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day15DuelingGenerators

  describe "final_count/1" do
    test "A uses 65, while generator B uses 8921, 40 million pairs, a total of 588 pairs that match in their lowest 16 bits" do
      assert 588 = {65, 8921} |> final_count()
    end

    test "with puzzle input" do
      # with_puzzle_input("input/day_15_dueling_generators.txt", fn input ->
      assert 619 = {591, 393} |> final_count()
      # end)
    end
  end
end
