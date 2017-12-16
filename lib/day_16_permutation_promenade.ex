defmodule Adventofcode.Day16PermutationPromenade do
  def what_order(input, dancers_size) do
    dancers = ?a..?z |> Enum.take(dancers_size) |> to_string
    instructions = parse(input)
    dance(dancers, instructions)
  end

  def parse(input) do
    input
    |> String.split(",")
    |> Enum.map(&parse_instruction/1)
  end

  defp parse_instruction("x" <> input) do
    [_, a, b] = Regex.run(~r/^(\d+)\/(\d+)$/, input)
    [a, b] = Enum.map([a, b], &String.to_integer/1)
    [a, b] = Enum.sort([a, b])
    {:exchange, a, b}
  end

  defp parse_instruction("p" <> input) do
    [_, a, b] = Regex.run(~r/^(\w+)\/(\w+)$/, input)
    [a, b] = Enum.sort([a, b])
    {:partner, a, b}
  end

  defp parse_instruction("s" <> a) do
    {:spin, String.to_integer(a)}
  end

  def dance(dancers, []), do: dancers

  def dance(dancers, [instruction | instructions]) do
    dancers
    |> dance(instruction)
    |> dance(instructions)
  end

  def dance(dancers, {:exchange, a, b}) do
    Enum.join([
      String.slice(dancers, 0, a),
      String.at(dancers, b),
      String.slice(dancers, a + 1, b - a - 1),
      String.at(dancers, a),
      String.slice(dancers, (b + 1)..-1)
    ])
  end

  def dance(dancers, {:spin, a}) do
    String.slice(dancers, -a..-1) <> String.slice(dancers, 0..(-a - 1))
  end

  def dance(dancers, {:partner, a, b}) do
    dancers
    |> String.replace(a, "?")
    |> String.replace(b, a)
    |> String.replace("?", b)
  end
end
