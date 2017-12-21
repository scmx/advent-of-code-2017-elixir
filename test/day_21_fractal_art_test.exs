defmodule Adventofcode.Day21FractalArtTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day21FractalArt

  describe "pixels_left_on_count/2" do
    @input """
    ../.# => ##./#../...
    .#./..#/### => #..#/..../..../#..#
    """
    test "after 2 iterations, the grid contains 12 pixels that are on" do
      assert 12 = @input |> pixels_left_on_count(2)
    end

    test "with puzzle input and 5 iterations" do
      with_puzzle_input("input/day_21_fractal_art.txt", fn input ->
        assert 176 = input |> pixels_left_on_count(5)
      end)
    end

    test "with puzzle input and 18 iterations" do
      with_puzzle_input("input/day_21_fractal_art.txt", fn input ->
        assert 2_368_161 = input |> pixels_left_on_count(18)
      end)
    end
  end
end
