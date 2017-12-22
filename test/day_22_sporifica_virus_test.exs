defmodule Adventofcode.Day22SporificaVirusTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day22SporificaVirus

  describe "bursts_infected_count/2" do
    @input """
    ..#
    #..
    ...
    """
    test "5/7 bursts cause a node to be infected" do
      assert 5 = @input |> bursts_infected_count(7)
    end

    test "41/70 bursts cause a node to be infected" do
      assert 41 = @input |> bursts_infected_count(70)
    end

    test "5587/10000 bursts cause a node to be infected" do
      assert 5587 = @input |> bursts_infected_count(10_000)
    end

    test "with puzzle input and 10000 iterations" do
      with_puzzle_input("input/day_22_sporifica_virus.txt", fn input ->
        assert 5305 = input |> bursts_infected_count(10_000)
      end)
    end
  end

  describe "pretty_grid/1" do
    @input """
    ..#
    #..
    ...
    """

    @expected """
    . . . . . . . . .
    . . . . . . . . .
    . . . . . . . . .
    . . . . . # . . .
    . . . #[.]. . . .
    . . . . . . . . .
    . . . . . . . . .
    . . . . . . . . .
    . . . . . . . . .
    """
    test "after 0 bursts" do
      state = @input |> new(0)
      assert pretty_grid(state, -4..4) == @expected
    end

    @expected """
    . . . . . . . . .
    . . . . . . . . .
    . . . . . . . . .
    . . . . . # . . .
    . . .[#]# . . . .
    . . . . . . . . .
    . . . . . . . . .
    . . . . . . . . .
    . . . . . . . . .
    """
    test "after 1 burst" do
      state = @input |> new(1) |> burst_repeatedly()
      assert pretty_grid(state, -4..4) == @expected
    end

    @expected """
    . . . . . . . . .
    . . . . . . . . .
    . . . . . . . . .
    . . .[.]. # . . .
    . . . . # . . . .
    . . . . . . . . .
    . . . . . . . . .
    . . . . . . . . .
    . . . . . . . . .
    """
    test "after 2 bursts" do
      state = @input |> new(2) |> burst_repeatedly()
      assert pretty_grid(state, -4..4) == @expected
    end

    @expected """
    . . . . . . . . .
    . . . . . . . . .
    . . . . . . . . .
    . . #[#]. # . . .
    . . # # # . . . .
    . . . . . . . . .
    . . . . . . . . .
    . . . . . . . . .
    . . . . . . . . .
    """
    test "after 6 bursts" do
      state = @input |> new(6) |> burst_repeatedly()
      assert pretty_grid(state, -4..4) == @expected
    end

    @expected """
    . . . . . . . . .
    . . . . . . . . .
    . . . . . . . . .
    . . # .[.]# . . .
    . . # # # . . . .
    . . . . . . . . .
    . . . . . . . . .
    . . . . . . . . .
    . . . . . . . . .
    """
    test "after 7 bursts" do
      state = @input |> new(7) |> burst_repeatedly()
      assert pretty_grid(state, -4..4) == @expected
    end

    @expected """
    . . . . . # # . .
    . . . . # . . # .
    . . . # . . . . #
    . . # . #[.]. . #
    . . # . # . . # .
    . . . . . # # . .
    . . . . . . . . .
    . . . . . . . . .
    . . . . . . . . .
    """
    test "after 70 bursts" do
      state = @input |> new(70) |> burst_repeatedly()
      assert pretty_grid(state, -4..4) == @expected
    end
  end
end
