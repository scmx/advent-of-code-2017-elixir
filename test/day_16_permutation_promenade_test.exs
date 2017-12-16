defmodule Adventofcode.Day16PermutationPromenadeTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day16PermutationPromenade

  describe "what_order/2" do
    test "stands as expected after dancing" do
      assert "baedc" = "s1,x3/4,pe/b" |> what_order(5)
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_16_permutation_promenade.txt", fn input ->
        assert "namdgkbhifpceloj" = input |> what_order(16)
      end)
    end
  end

  describe "dance/2" do
    @expected [
      "eabcd",
      "eabdc",
      "baedc"
    ]
    test "dances as expected" do
      cases = "s1,x3/4,pe/b" |> parse() |> Enum.zip(@expected)

      Enum.reduce(cases, "abcde", fn {instruction, expected}, dancers ->
        dancers = dance(dancers, instruction)
        assert dancers == expected
        dancers
      end)
    end

    @expected [
      "abcdefghijklonmp",
      "fghijklonmpabcde",
      "fghipklonmjabcde",
      "mjabcdefghipklon",
      "mjaocdefghipklbn"
    ]
    test "dances as expected with parts of puzzle input" do
      cases = "x12/14,s11,x10/4,s7,pb/o" |> parse() |> Enum.zip(@expected)

      Enum.reduce(cases, "abcdefghijklmnop", fn {instruction, expected}, dancers ->
        acc = dance(dancers, instruction)
        assert acc == expected
        acc
      end)
    end
  end
end
