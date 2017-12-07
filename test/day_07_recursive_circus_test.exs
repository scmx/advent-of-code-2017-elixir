defmodule Adventofcode.Day07RecursiveCircusTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day07RecursiveCircus

  describe "bottom_program/1" do
    #                 gyxo
    #               /
    #          ugml - ebii
    #        /      \
    #       |         jptl
    #       |
    #       |         pbga
    #     /        /
    # tknk --- padx - havc
    #     \        \
    #       |         goyq
    #       |
    #       |         ktlj
    #        \      /
    #          fwft - cntj
    #               \
    #                 xhth

    @input """
    pbga (66)
    xhth (57)
    ebii (61)
    havc (66)
    ktlj (57)
    fwft (72) -> ktlj, cntj, xhth
    qoyq (66)
    padx (45) -> pbga, havc, qoyq
    tknk (41) -> ugml, padx, fwft
    jptl (61)
    ugml (68) -> gyxo, ebii, jptl
    gyxo (61)
    cntj (57)
    """
    test "finds the correct bottom program" do
      assert "tknk" = @input |> bottom_program()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_07_recursive_circus.txt", fn input ->
        assert "vgzejbd" = input |> bottom_program()
      end)
    end
  end
end
