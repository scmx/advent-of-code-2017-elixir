defmodule Adventofcode.Day06MemoryReallocation do
  defstruct banks: [], history: [], cycles: 0, done: false

  def cycles_in_total_until_same(input) do
    initial_state = new(input)
    redistribute_recursively(initial_state)
  end

  def new(input) do
    %__MODULE__{banks: parse(input)}
  end

  def redistribute_recursively(state) do
    state = redistribute(state)

    if same_as_previous?(state) do
      state.cycles
    else
      redistribute_recursively(state)
    end
  end

  def same_as_previous?(%{banks: banks, history: [_ | history]}) do
    Enum.any?(history, &(&1 == banks))
  end

  def redistribute(state) do
    banks = spread_out(state.banks)
    history = [banks | state.history]

    %{state | banks: banks, cycles: state.cycles + 1, history: history}
  end

  def spread_out(banks) do
    indexed_banks = Enum.with_index(banks)

    index =
      indexed_banks
      |> Enum.sort_by(fn {val, index} -> {-val, index} end)
      |> List.first()
      |> elem(1)

    amount = Enum.at(banks, index)
    banks = List.update_at(banks, index, fn _ -> 0 end)
    part = (amount / length(banks)) |> Float.ceil() |> trunc() |> rem(amount)
    do_spread_out(banks, rem(index + 1, length(banks)), amount, part)
  end

  defp do_spread_out(banks, _index, 0, _each_part), do: banks

  defp do_spread_out(banks, index, amount, each_part) do
    part = if each_part > amount, do: amount, else: each_part
    amount_left = amount - part
    banks = List.update_at(banks, index, &(&1 + part))
    do_spread_out(banks, rem(index + 1, length(banks)), amount_left, each_part)
  end

  defp parse(input) do
    ~r/-?\d+/
    |> Regex.scan(input)
    |> List.flatten()
    |> Enum.map(&String.to_integer/1)
  end

  @doc false
  def pretty(%{banks: banks}), do: Enum.join(banks, " ")
end
