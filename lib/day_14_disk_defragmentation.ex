defmodule Adventofcode.Day14DiskDefragmentation do
  alias Adventofcode.Day10KnotHash

  def squares_count(input) do
    0..127
    |> Enum.map(&"#{input}-#{&1}")
    |> Enum.map(&Day10KnotHash.knot_hash/1)
    |> Enum.map(&convert_hash_to_bits/1)
    |> Enum.map(&used_square_count/1)
    |> Enum.sum()
  end

  defp convert_hash_to_bits(hex_hash) do
    hex_hash
    |> String.graphemes()
    |> Enum.map(&convert_hex_digit_to_bits/1)
    |> Enum.join()
  end

  defp convert_hex_digit_to_bits(hex_digit) do
    hex_digit
    |> String.to_integer(16)
    |> Integer.to_string(2)
    |> String.pad_leading(4, "0")
  end

  defp used_square_count(line) do
    line
    |> String.graphemes()
    |> Enum.filter(&(&1 == "1"))
    |> Enum.count()
  end
end
