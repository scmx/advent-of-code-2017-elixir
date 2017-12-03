defmodule Adventofcode.Day03SpiralMemory do
  require Integer

  def steps_to_access_port(input) when is_binary(input) do
    steps_to_access_port(String.to_integer(input))
  end

  def steps_to_access_port(1), do: 0

  def steps_to_access_port(value) when is_number(value) do
    circle = get_inner_circle(value)
    smaller_area = :math.pow(circle, 2) |> round()
    bigger_area = :math.pow(circle + 2, 2) |> round()
    diff_area = (bigger_area - smaller_area) |> round()
    side_len = (diff_area / 4) |> Float.floor() |> round()
    len = rem(value - smaller_area - 1, side_len)
    mid = (side_len / 2 - 1) |> Float.floor() |> round()
    out_steps = ((circle + 1) / 2) |> Float.floor() |> round()

    cond do
      len == mid -> out_steps
      len < mid -> out_steps + mid - len
      len > mid -> out_steps + len - mid
    end
  end

  defp get_inner_circle(value) do
    rounded_sqrt = :math.pow(value - 1, 1 / 2) |> Float.floor() |> round()
    if Integer.is_even(rounded_sqrt), do: rounded_sqrt - 1, else: rounded_sqrt
  end

  def first_bigger_value(input) when is_binary(input) do
    first_bigger_value(String.to_integer(input))
  end

  defstruct goal: nil,
            value: 1,
            direction: :east,
            coordinate: {0, 0},
            visited: %{{0, 0} => 1}

  def first_bigger_value(value) do
    do_travel(%__MODULE__{goal: value})
  end

  defp do_travel(%{goal: goal, value: value}) when value > goal, do: value

  defp do_travel(state) do
    {coordinate, rotation} = next_coordinate_and_direction(state)

    value = neighbour_sum(state.visited, coordinate)

    direction =
      if Map.has_key?(state.visited, next_coordinate(coordinate, rotation)) do
        state.direction
      else
        rotation
      end

    visited = Map.put(state.visited, coordinate, value)

    %{state | coordinate: coordinate, value: value, direction: direction, visited: visited}
    |> do_travel()
  end

  defp neighbour_sum(visited, current) do
    neighbour_circle = [:east, :north, :west, :west, :south, :south, :east, :east]

    {neighbours, _} =
      Enum.map_reduce(neighbour_circle, current, fn direction, coordinate ->
        next = next_coordinate(coordinate, direction)
        {next, next}
      end)

    neighbours
    |> Enum.map(&Map.get(visited, &1))
    |> Enum.filter(& &1)
    |> Enum.sum()
  end

  defp next_coordinate_and_direction(state) do
    case state.direction do
      :east -> {next_coordinate(state), :north}
      :north -> {next_coordinate(state), :west}
      :west -> {next_coordinate(state), :south}
      :south -> {next_coordinate(state), :east}
    end
  end

  defp next_coordinate(%{coordinate: coordinate, direction: direction}) do
    next_coordinate(coordinate, direction)
  end

  defp next_coordinate({x, y}, direction) do
    case direction do
      :east -> {x + 1, y}
      :north -> {x, y - 1}
      :west -> {x - 1, y}
      :south -> {x, y + 1}
    end
  end
end
