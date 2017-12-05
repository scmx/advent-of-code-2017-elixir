defmodule Adventofcode.Day04PassphrasesTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day04Passphrases

  describe "valid_count/1" do
    test "aa bb cc dd ee is valid" do
      assert 1 = "aa bb cc dd ee" |> valid_count
    end

    test "aa bb cc dd aa is not valid - the word aa appears more than once" do
      assert 0 = "aa bb cc dd aa" |> valid_count
    end

    test "aa bb cc dd aaa is valid - aa and aaa count as different words" do
      assert 1 = "aa bb cc dd aaa" |> valid_count
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_04_passphrases.txt", fn input ->
        assert 451 = input |> valid_count()
      end)
    end
  end

  describe "valid_count_anagram/1" do
    test "abcde fghij is a valid passphrase" do
      assert 1 = "abcde fghij" |> valid_count_anagram
    end

    test "abcde xyz ecdab is not valid - the letters from the third word can be rearranged to form the first word" do
      assert 0 = "abcde xyz ecdab" |> valid_count_anagram
    end

    test "a ab abc abd abf abj is a valid passphrase, because all letters need to be used when forming another word" do
      assert 1 = "a ab abc abd abf abj" |> valid_count_anagram
    end

    test "iiii oiii ooii oooi oooo is valid" do
      assert 1 = "iiii oiii ooii oooi oooo" |> valid_count_anagram
    end

    test "oiii ioii iioi iiio is not valid - any of these words can be rearranged to form any other word" do
      assert 0 = "oiii ioii iioi iiio" |> valid_count_anagram
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_04_passphrases.txt", fn input ->
        assert 223 = input |> valid_count_anagram()
      end)
    end
  end
end
