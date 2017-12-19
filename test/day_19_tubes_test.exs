defmodule Adventofcode.Day19TubesTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day19Tubes

  describe "what_letters/1" do
    @input """
        |         
        |  +--+   
        A  |  C   
    F---|----E|--+
        |  |  |  D
        +B-+  +--+
    """
    test "sees the expected letters" do
      assert "ABCDEF" = @input |> what_letters()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_19_tubes.txt", [trim: false], fn input ->
        assert "BPDKCZWHGT" = input |> what_letters()
      end)
    end
  end

  describe "how_many_steps/1" do
    @input """
        |         
        |  +--+   
        A  |  C   
    F---|----E|--+
        |  |  |  D
        +B-+  +--+
    """
    test "takes expected number of steps" do
      assert 38 = @input |> how_many_steps()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_19_tubes.txt", [trim: false], fn input ->
        assert 17728 = input |> how_many_steps()
      end)
    end
  end
end
