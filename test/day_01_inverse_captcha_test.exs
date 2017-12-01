defmodule Adventofcode.Day01InverseCaptchaTest do
  use ExUnit.Case

  import Adventofcode.Day01InverseCaptcha
  import Adventofcode.TestHelpers

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
end
