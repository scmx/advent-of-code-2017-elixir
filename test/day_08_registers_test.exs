defmodule Adventofcode.Day08RegistersTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day08Registers

  describe "largest_register_afterwards/1" do
    @instructions """
    b inc 5 if a > 1
    a inc 1 if b < 5
    c dec -10 if a >= 1
    c inc -20 if c == 10
    """
    test "processes instructions and finds the largest register" do
      assert 1 = @instructions |> largest_register_afterwards()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_08_registers.txt", fn input ->
        assert 4163 = input |> largest_register_afterwards()
      end)
    end
  end

  describe "process_instruction/2" do
    @instructions [
      {{{"b", "inc", 5}, {"a", ">", 1}}, %{}},
      {{{"a", "inc", 1}, {"b", "<", 5}}, %{"a" => 1}},
      {{{"c", "dec", -10}, {"a", ">=", 1}}, %{"a" => 1, "c" => 10}},
      {{{"c", "inc", -20}, {"c", "==", 10}}, %{"a" => 1, "c" => -10}}
    ]
    test "processes instruction as expected" do
      Enum.reduce(@instructions, %{}, fn {instruction, expected}, registers ->
        result = process_instruction(instruction, registers)
        assert result == expected
        result
      end)
    end
  end
end
