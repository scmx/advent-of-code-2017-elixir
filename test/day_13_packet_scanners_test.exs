defmodule Adventofcode.Day13PacketScannersTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day13PacketScanners

  describe "severity/1" do
    # Initial state:
    #  0   1   2   3   4   5   6
    # [S] [S] ... ... [S] ... [S]
    # [ ] [ ]         [ ]     [ ]
    # [ ]             [ ]     [ ]
    #                 [ ]     [ ]
    #
    # Picosecond 0:
    #  0   1   2   3   4   5   6
    # (S) [S] ... ... [S] ... [S]
    # [ ] [ ]         [ ]     [ ]
    # [ ]             [ ]     [ ]
    #                 [ ]     [ ]
    # ...
    #
    # Picosecond 6:
    #  0   1   2   3   4   5   6
    # [ ] [S] ... ... [S] ... (S)
    # [ ] [ ]         [ ]     [ ]
    # [S]             [ ]     [ ]
    #                 [ ]     [ ]

    @input """
    0: 3
    1: 2
    4: 4
    6: 4
    """
    test "the trip severity is 0*3 + 6*4 = 24" do
      assert 24 = @input |> severity()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_13_packet_scanners.txt", fn input ->
        assert 1876 = input |> severity()
      end)
    end
  end

  describe "minimum_delay/1" do
    # What is the fewest number of picoseconds that you need to delay the
    # packet to pass through the firewall without being caught?

    @input """
    0: 3
    1: 2
    4: 4
    6: 4
    """
    test "the trip severity is 0*3 + 6*4 = 24" do
      assert 10 = @input |> minimum_delay()
    end

    @tag timeout: 300_000
    test "with puzzle input" do
      with_puzzle_input("input/day_13_packet_scanners.txt", fn input ->
        assert 3_964_778 = input |> minimum_delay()
      end)
    end
  end
end
