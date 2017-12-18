defmodule Adventofcode.Day18Duet.RecoveredFrequency do
  defstruct registers: %{}, instructions: [], current_index: 0, last_played: nil, recovered: false

  def recovered_frequency_value(input) do
    %__MODULE__{instructions: parse(input)}
    |> process_instructions()
    |> result()
  end

  defp result(%{last_played: nil} = state), do: state
  defp result(%{last_played: last_played}), do: last_played

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
      state.recovered -> state
      state.current_index < 0 -> state
      state.current_index >= length(state.instructions) -> state
      true -> do_process_instruction(state)
    end
  end

  defp do_process_instruction(state) do
    instruction = Enum.at(state.instructions, state.current_index)
    {index_add, updates} = process(instruction, state)

    updates
    |> Enum.reduce(state, fn {k, v}, acc -> Map.put(acc, k, v) end)
    |> Map.update(:current_index, index_add, &(&1 + index_add))
    |> process_instructions()
  end

  defp process([name, register, value], state) when is_binary(value) do
    process([name, register, Map.get(state.registers, value, 0)], state)
  end

  defp process(["set", register, value], state) do
    registers = Map.put(state.registers, register, value)
    {1, registers: registers}
  end

  defp process(["add", register, value], state) do
    registers = Map.update(state.registers, register, value, &(&1 + value))
    {1, registers: registers}
  end

  defp process(["mul", register, value], state) do
    registers = Map.update(state.registers, register, 0, &(&1 * value))
    {1, registers: registers}
  end

  defp process(["mod", register, value], state) do
    registers = Map.update(state.registers, register, value, &rem(&1, value))
    {1, registers: registers}
  end

  defp process(["jgz", register, value], state) do
    if Map.get(state.registers, register) <= 0 do
      {1, []}
    else
      {value, []}
    end
  end

  defp process(["snd", register], state) do
    value = Map.get(state.registers, register)
    {1, last_played: value}
  end

  defp process(["rcv", register], state) do
    if Map.get(state.registers, register) == 0 do
      {1, []}
    else
      {0, recovered: true}
    end
  end
end
