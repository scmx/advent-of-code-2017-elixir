defmodule Adventofcode.Day01InverseCaptcha do
  def matching_sum(input) do
    input
    |> copy_first_digit_to_end
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> do_sum(%{})
  end

  defp do_sum([], results) do
    results
    |> Enum.reduce(0, fn {k, v}, acc -> k * v + acc end)
  end

  defp do_sum([head, head | tail], results) do
    do_sum([head | tail], add_one(results, head))
  end

  defp do_sum([_head | tail], results), do: do_sum(tail, results)

  defp copy_first_digit_to_end(digits), do: digits <> String.first(digits)

  defp add_one(results, digit), do: Map.update(results, digit, 1, &(&1 + 1))

  def halfway_sum(input) do
    input
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> do_halfway_sum()
  end

  defp do_halfway_sum(digits) do
    digit_cycle = Stream.cycle(digits)
    halfway = digits |> length |> div(2)

    Enum.reduce(Enum.with_index(digits), 0, fn {digit, index}, acc ->
      case Enum.at(digit_cycle, index + halfway) do
        ^digit -> acc + digit
        _ -> acc
      end
    end)
  end
end
