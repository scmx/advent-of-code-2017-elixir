defmodule Adventofcode.Day02CorruptionChecksum do
  def checksum(input) do
    input
    |> parse
    |> Enum.map(&difference/1)
    |> Enum.sum()
  end

  defp parse(input) do
    input
    |> String.trim_trailing()
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
    |> Enum.map(&Enum.sort/1)
    |> Enum.map(&Enum.reverse/1)
  end

  defp parse_line(line) do
    ~r/\d+/
    |> Regex.scan(line)
    |> List.flatten()
    |> Enum.map(&String.to_integer/1)
  end

  defp difference(numbers) do
    List.first(numbers) - List.last(numbers)
  end

  def division_checksum(input) do
    input
    |> parse
    |> Enum.map(&divide_evenly_divisible_values/1)
    |> Enum.sum()
  end

  defp divide_evenly_divisible_values([head | tail]) do
    case Enum.find(tail, &(rem(head, &1) == 0)) do
      nil -> divide_evenly_divisible_values(tail)
      val -> div(head, val)
    end
  end
end
