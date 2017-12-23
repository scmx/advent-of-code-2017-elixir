defmodule Adventofcode.Day10KnotHash do
  require Bitwise

  defstruct current: 0, skip: 0, size: 255, lengths: [], values: {}

  def first_two_sum(input, list_size \\ 256) do
    input
    |> build_lengths
    |> new(list_size)
    |> process_recursively
    |> sum_of_first_two
  end

  def knot_hash(input) do
    input
    |> build_lengths_from_ascii
    |> new(256)
    |> process_lengths_many_times(64)
    |> sparse_hash_to_dense_hash
    |> dense_hash_to_hexadecimal
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

  @standard_length_suffix [17, 31, 73, 47, 23]
  def build_lengths_from_ascii(input) do
    String.to_charlist(input) ++ @standard_length_suffix
  end

  def process_recursively(%{lengths: []} = state), do: state

  def process_recursively(state) do
    state
    |> process()
    |> process_recursively()
  end

  defp process_lengths_many_times(state, times) do
    do_process_lengths_many_times(state, times, state.lengths)
  end

  defp do_process_lengths_many_times(state, 0, _lengths), do: state

  defp do_process_lengths_many_times(state, times, lengths) when times > 0 do
    %{state | lengths: lengths}
    |> process_recursively
    |> do_process_lengths_many_times(times - 1, lengths)
  end

  def process(%{lengths: [head | tail]} = state) do
    values = reverse(state, state.current, head)
    current = rem(state.current + head + state.skip, state.size)
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

  defp sparse_hash_to_dense_hash(%{values: values, size: 256}) do
    values
    |> Tuple.to_list()
    |> Enum.chunk(16)
    |> Enum.map(fn digits -> Enum.reduce(digits, &Bitwise.bxor/2) end)
  end

  def dense_hash_to_hexadecimal(dense_hash) do
    dense_hash
    |> Enum.map(&Integer.to_string(&1, 16))
    |> Enum.map_join(&String.pad_leading(&1, 2, "0"))
    |> String.downcase()
  end

  def pretty(%{current: current} = state) do
    Enum.map_join(Enum.with_index(Tuple.to_list(state.values)), fn
      {value, ^current} -> "[#{value}]"
      {value, _index} -> " #{value} "
    end)
  end
end
