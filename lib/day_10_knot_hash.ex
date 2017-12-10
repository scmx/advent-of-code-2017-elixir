defmodule Adventofcode.Day10KnotHash do
  defstruct current: 0, skip: 0, size: 255, lengths: [], values: {}

  def first_two_sum(input, list_size \\ 256) do
    input
    |> build_lengths
    |> new(list_size)
    |> process_recursively
    |> sum_of_first_two
  end

  defp sum_of_first_two(%{values: values}), do: elem(values, 0) * elem(values, 1)

  def new(lengths, list_size) do
    values = 0..(list_size - 1) |> Enum.to_list() |> List.to_tuple()
    %__MODULE__{size: list_size, lengths: lengths, values: values}
  end

  def build_lengths(input) do
    input
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  def process_recursively(%{lengths: []} = state), do: state

  def process_recursively(state) do
    state
    |> process()
    |> process_recursively()
  end

  def process(%{lengths: [head | tail]} = state) do
    values = reverse(state, state.current, head)
    current = rem(state.current + head + state.skip, tuple_size(state.values))
    skip = state.skip + 1
    %{state | current: current, skip: skip, lengths: tail, values: values}
  end

  def reverse(state, current, len) do
    reversed =
      current..(current + len - 1)
      |> Enum.map(&rem(&1, state.size))
      |> Enum.map(&elem(state.values, &1))
      |> Enum.reverse()

    Enum.reduce(Enum.with_index(reversed), state.values, fn {value, offset}, acc ->
      index = rem(state.current + offset, state.size)
      put_elem(acc, index, value)
    end)
  end

  def pretty(%{current: current} = state) do
    Enum.map_join(Enum.with_index(Tuple.to_list(state.values)), fn
      {value, ^current} -> "[#{value}]"
      {value, _index} -> " #{value} "
    end)
  end
end
