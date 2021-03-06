defmodule Adventofcode.Day03SpiralMemoryTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day03SpiralMemory

  describe "steps_to_access_port/1" do
    # 17 16 15 14 13
    # 18  5  4  3 12
    # 19  6  1  2 11
    # 20  7  8  9 10
    # 21 22 23--> ..

    test "data from square 1 is carried 0 steps, since it's at the access port" do
      assert 0 = 1 |> steps_to_access_port()
    end

    test "data from square 12 is carried 3 steps, such as: down, left, left" do
      assert 3 = 12 |> steps_to_access_port()
    end

    test "data from square 23 is carried only 2 steps: up twice" do
      assert 2 = 23 |> steps_to_access_port()
    end

    test "data from square 1024 must be carried 31 steps" do
      assert 31 = 1024 |> steps_to_access_port()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_03_spiral_memory.txt", fn input ->
        assert 552 = input |> steps_to_access_port()
      end)
    end

    # 64 63 62 61 60 59 58
    # 37 36 35 34 33 32 31
    # 38 17 16 15 14 13 30
    # 39 18  5  4  3 12 29
    # 40 19  6  1  2 11 28
    # 41 20  7  8  9 10 27
    # 42 21 22 23 24 25 26
    # 43 44 45 46 47 48 49 50
    @expected_distances ~i"""
    0 1 2 1 2 1 2 1 2 3 2 3 4 3 2 3 4 3 2 3 4 3 2 3 4 5 4 3 4 5 6 5 4 3 4 5 6 5
    4 3 4 5 6 5 4 3 4 5 6 7
    """
    test "1..50 gives no unexpected results" do
      cases =
        Enum.map(Enum.with_index(@expected_distances), fn {expected, index} ->
          input = index + 1
          actual = steps_to_access_port(input)
          result = if actual == expected, do: :ok, else: :fail
          [result, input, expected, actual]
        end)

      unless Enum.all?(cases, &(hd(&1) == :ok)) do
        format = "~4s   ~3.. B ~3.. B ~3.. B"
        pretty_cases = Enum.map_join(cases, "\n", &:io_lib.format(format, &1))
        message = "  input expected actual\n#{pretty_cases}"
        raise ExUnit.AssertionError, message
      end
    end
  end

  describe "first_bigger_value/1" do
    # 147  142  133  122   59
    # 304    5    4    2   57
    # 330   10    1    1   54
    # 351   11   23   25   26
    # 362  747  806--->   ...

    @expected_values ~i"""
    1 2 4 5 10 11 23 25 26 54 57 59 122 133 142 147 304 330 351 362 747 806
    """
    test "gives the expected number series on iteration" do
      stream = Stream.iterate(1, &first_bigger_value/1)

      assert Enum.take(stream, 22) == @expected_values
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_03_spiral_memory.txt", fn input ->
        assert 330_785 = input |> first_bigger_value()
      end)
    end
  end
end
