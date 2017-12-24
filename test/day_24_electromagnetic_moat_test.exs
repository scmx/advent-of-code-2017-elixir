defmodule Adventofcode.Day24ElectromagneticMoatTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day24ElectromagneticMoat

  describe "strongest_bridge/1" do
    @input "0/2 2/2 2/3 3/4 3/5 0/1 10/1 9/10"
    test "" do
      assert 31 = @input |> strongest_bridge()
    end

    test "with_puzzle_input" do
      with_puzzle_input("input/day_24_electromagnetic_moat.txt", fn input ->
        assert 1906 = input |> strongest_bridge()
      end)
    end
  end
end
