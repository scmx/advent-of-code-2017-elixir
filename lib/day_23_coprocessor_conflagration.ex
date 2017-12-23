defmodule Adventofcode.Day23CoprocessorConflagration do
  defstruct registers: %{
              "a" => 0,
              "b" => 0,
              "c" => 0,
              "d" => 0,
              "e" => 0,
              "f" => 0,
              "g" => 0,
              "h" => 0
            },
            instructions: [],
            current_index: 0,
            mul_count: 0

  def how_many_mul(input) do
    %__MODULE__{instructions: parse(input)}
    |> process_instructions()
    |> Map.get(:mul_count)
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    [name | args] = String.split(line, " ")
    [name | Enum.map(args, &parse_arg/1)]
  end

  defp parse_arg(arg) do
    case Integer.parse(arg) do
      {num, ""} -> num
      _ -> arg
    end
  end

  defp process_instructions(state) do
    cond do
      state.current_index < 0 -> state
      state.current_index >= length(state.instructions) -> state
      true -> do_process_instruction(state)
    end
  end

  defp do_process_instruction(state) do
    instruction = Enum.at(state.instructions, state.current_index)
    {index_add, updates} = process(instruction, state)

    updates
    |> Enum.reduce(state, fn {k, v}, acc -> %{acc | k => v} end)
    |> Map.update(:current_index, index_add, &(&1 + index_add))
    |> print_state()
    |> process_instructions()
  end

  defp process([name, register, value], state) when is_binary(value) do
    process([name, register, Map.get(state.registers, value, 0)], state)
  end

  defp process(["set", register, value], state) do
    registers = %{state.registers | register => value}
    {1, registers: registers}
  end

  defp process(["sub", register, value], %{registers: registers}) do
    registers = %{registers | register => registers[register] - value}
    {1, registers: registers}
  end

  defp process(["mul", register, value], %{registers: registers} = state) do
    registers = %{registers | register => registers[register] * value}
    {1, registers: registers, mul_count: state.mul_count + 1}
  end

  defp process(["jnz", register, value], state) do
    cond do
      register == 0 -> {1, []}
      Map.get(state.registers, register) == 0 -> {1, []}
      true -> {value, []}
    end
  end

  defp print_state(state) do
    state
  end
end
