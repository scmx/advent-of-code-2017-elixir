defmodule Adventofcode.Day01InverseCaptchaTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day01InverseCaptcha

  describe "matching_sum/1" do
    test "1122 produces a sum of 3 (1 + 2) because the first digit (1) matches the second digit and the third digit (2) matches the fourth digit" do
      assert 3 = "1122" |> matching_sum()
    end

    test "1111 produces 4 because each digit (all 1) matches the next" do
      assert 4 = "1111" |> matching_sum()
    end

    test "1234 produces 0 because no digit matches the next" do
      assert 0 = "1234" |> matching_sum()
    end

    test "91212129 produces 9 because the only digit that matches the next one is the last digit, 9" do
      assert 9 = "91212129" |> matching_sum()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_01_inverse_captcha.txt", fn input ->
        assert 1341 = input |> matching_sum()
      end)
    end
  end

  describe "halfway_sum/1" do
    test "1212 produces 6: the list contains 4 items, and all four digits match the digit 2 items ahead" do
      assert 6 = "1212" |> halfway_sum()
    end

    test "1221 produces 0, because every comparison is between a 1 and a 2" do
      assert 0 = "1221" |> halfway_sum()
    end

    test "123425 produces 4, because both 2s match each other, but no other digit has a match" do
      assert 4 = "123425" |> halfway_sum()
    end

    test "123123 produces 12" do
      assert 12 = "123123" |> halfway_sum()
    end

    test "12131415 produces 4" do
      assert 4 = "12131415" |> halfway_sum()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_01_inverse_captcha.txt", fn input ->
        assert 1348 = input |> halfway_sum()
      end)
    end
  end
end
