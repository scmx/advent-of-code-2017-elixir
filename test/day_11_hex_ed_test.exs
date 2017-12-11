defmodule Adventofcode.Day11HexEdTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day11HexEd

  describe "steps_away/1" do
    test "ne,ne,ne is 3 steps away" do
      assert 3 = "ne,ne,ne" |> steps_away()
    end

    test "ne,ne,sw,sw is 0 steps away (back where you started)" do
      assert 0 = "ne,ne,sw,sw" |> steps_away()
    end

    test "ne,ne,s,s is 2 steps away (se,se)" do
      assert 2 = "ne,ne,s,s" |> steps_away()
    end

    test "se,sw,se,sw,sw is 3 steps away (s,s,sw)" do
      assert 3 = "se,sw,se,sw,sw" |> steps_away()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_11_hex_ed.txt", fn input ->
        assert 685 = input |> steps_away()
      end)
    end
  end

  describe "furthest_away/1" do
    test "ne,ne,ne was 3 steps away at most" do
      assert 3 = "ne,ne,ne" |> furthest_away()
    end

    test "ne,ne,sw,sw was 2 steps away at most" do
      assert 2 = "ne,ne,sw,sw" |> furthest_away()
    end

    test "ne,ne,s,s was 2 steps away at most" do
      assert 2 = "ne,ne,s,s" |> furthest_away()
    end

    test "se,sw,se,sw,sw was 3 steps away at most" do
      assert 3 = "se,sw,se,sw,sw" |> furthest_away()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_11_hex_ed.txt", fn input ->
        assert 1337 = input |> furthest_away()
      end)
    end
  end
end
