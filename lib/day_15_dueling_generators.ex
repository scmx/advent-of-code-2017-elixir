defmodule Adventofcode.Day15DuelingGenerators do
  def final_count({a, b}) do
    do_final_count(40_000_000, [generator(a, 16807), generator(b, 48271)])
  end

  defp do_final_count(limit, [gen_a, gen_b]) do
    [gen_a, gen_b]
    |> Stream.zip()
    |> Enum.take(limit)
    |> Enum.count(&lowest_bits_of_binary_pairs_same?/1)
  end

  defp generator(initial, multiplier) do
    initial
    |> iterate(multiplier)
    |> Stream.iterate(&iterate(&1, multiplier))
  end

  defp iterate(val, multiplier) do
    rem(val * multiplier, 2_147_483_647)
  end

  defp lowest_bits_of_binary_pairs_same?({a, b}) do
    {a, b}
    |> binary_pairs()
    |> lowest_bits_same()
  end

  defp binary_pairs({a, b}) do
    {binary(a), binary(b)}
  end

  defp binary(val) do
    val
    |> Integer.to_string(2)
    |> String.pad_leading(32, "0")
  end

  defp lowest_bits_same({a, b}) do
    lowest_bits(a) == lowest_bits(b)
  end

  def lowest_bits(val) do
    String.slice(val, -16..-1)
  end
end
