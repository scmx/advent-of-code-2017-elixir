defmodule Adventofcode.Day15DuelingGenerators do
  use Bitwise

  def final_count(input) when is_binary(input), do: final_count(parse(input))

  def final_count({a, b}) do
    do_final_count(40_000_000, [generator(a, 16807), generator(b, 48271)])
  end

  def final_count_2(input) when is_binary(input), do: final_count_2(parse(input))

  def final_count_2({a, b}) do
    do_final_count(5_000_000, [
      generator(a, 16807, divisible(4)),
      generator(b, 48271, divisible(8))
    ])
  end

  @input_regex ~r/Generator A starts with (\d+)\nGenerator B starts with (\d+)/
  defp parse(input) do
    @input_regex
    |> Regex.run(input)
    |> tl()
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  defp divisible(amount) do
    &Stream.filter(&1, fn val -> rem(val, amount) == 0 end)
  end

  defp do_final_count(limit, [gen_a, gen_b]) do
    [gen_a, gen_b]
    |> Stream.zip()
    |> Enum.take(limit)
    |> Enum.count(&lowest_bits_of_binary_pairs_same?/1)
  end

  defp generator(initial, multiplier, filter \\ & &1) do
    initial
    |> iterate(multiplier)
    |> Stream.iterate(&iterate(&1, multiplier))
    |> filter.()
  end

  defp iterate(val, multiplier) do
    rem(val * multiplier, 2_147_483_647)
  end

  @mask (1 <<< 16) - 1
  defp lowest_bits_of_binary_pairs_same?({a, b}) do
    (a &&& @mask) ^^^ (b &&& @mask) == 0
  end
end
