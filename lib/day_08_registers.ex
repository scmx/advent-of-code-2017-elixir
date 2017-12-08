defmodule Adventofcode.Day08Registers do
  def largest_register_afterwards(input) do
    input
    |> parse()
    |> process()
    |> Map.values()
    |> Enum.max()
  end

  def parse(input) do
    input
    |> String.trim_trailing()
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
  end

  @operations ~w(inc dec)

  defp operation(registers, {name, "inc", value}) do
    Map.update(registers, name, value, &(&1 + value))
  end

  defp operation(registers, {name, "dec", value}) do
    Map.update(registers, name, -value, &(&1 - value))
  end

  @conditions ~w(> < >= <= == !=)
  defp condition(registers, {name, ">", value}) do
    Map.get(registers, name, 0) > value
  end

  defp condition(registers, {name, "<", value}) do
    Map.get(registers, name, 0) < value
  end

  defp condition(registers, {name, ">=", value}) do
    Map.get(registers, name, 0) >= value
  end

  defp condition(registers, {name, "<=", value}) do
    Map.get(registers, name, 0) <= value
  end

  defp condition(registers, {name, "==", value}) do
    Map.get(registers, name, 0) == value
  end

  defp condition(registers, {name, "!=", value}) do
    Map.get(registers, name, 0) != value
  end

  defp parse_line(line) do
    op = Enum.join(@operations, "|")
    con = Enum.join(@conditions, "|")
    line_regex = ~r/(\w+)\s+(#{op})\s+(-?\d+)\s+if\s+(\w+)\s+(#{con})\s(-?\d+)/

    case Regex.run(line_regex, line) do
      nil ->
        IO.inspect(line)
        nil

      results ->
        results
        |> tl()
        |> build_line()
    end
  end

  defp build_line([reg, op, val, reg2, con, val2])
       when op in @operations and con in @conditions do
    {{reg, op, String.to_integer(val)}, {reg2, con, String.to_integer(val2)}}
  end

  defp process(instructions, registers \\ %{})

  defp process([], registers), do: registers

  defp process([instruction | tail], registers) do
    result = process_instruction(instruction, registers)
    process(tail, result)
  end

  def process_instruction({operation, condition}, registers) do
    if condition(registers, condition) do
      operation(registers, operation)
    else
      registers
    end
  end
end
