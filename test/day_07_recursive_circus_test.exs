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

  describe "unbalanced_weight/1" do
    # ugml + (gyxo + ebii + jptl) = 68 + (61 + 61 + 61) = 251
    # padx + (pbga + havc + qoyq) = 45 + (66 + 66 + 66) = 243
    # fwft + (ktlj + cntj + xhth) = 72 + (57 + 57 + 57) = 243
    # 243 - 61 * 3 = 60

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
    test "finds that ugml would need a weight of 60" do
      assert 60 = @input |> unbalanced_weight()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_07_recursive_circus.txt", fn input ->
        assert 1226 = input |> unbalanced_weight()
      end)
    end
  end
end
