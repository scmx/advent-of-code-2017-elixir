defmodule Adventofcode.Day05TwistyTrampolines do
  def how_many_steps(input) do
    Enum.reduce_while(Stream.iterate(input, &iterate/1), nil, fn
      current, _previous when is_number(current) -> {:halt, current}
      current, _previous when is_binary(current) -> {:cont, current}
      current, _previous when is_tuple(current) -> {:cont, current}
    end)
  end

  @doc false
  def iterate(input) when is_binary(input) do
    values =
      ~r/-?\d+/
      |> Regex.scan(input)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()

    iterate({0, 0, values})
  end

  def iterate({index, iterations, values})
      when index < 0 or index >= tuple_size(values),
      do: iterations

  def iterate({index, iterations, values}) do
    value = elem(values, index)
    new_index = index + value
    new_values = put_elem(values, index, value + 1)
    {new_index, iterations + 1, new_values}
  end

  @doc false
  def pretty({current_index, _, values}) do
    Enum.map_join(Enum.with_index(Tuple.to_list(values)), fn
      {value, ^current_index} -> "(#{value})"
      {value, _index} -> " #{value} "
    end)
  end
end
