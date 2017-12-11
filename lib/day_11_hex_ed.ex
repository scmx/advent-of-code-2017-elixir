defmodule Adventofcode.Day11HexEd do
  defstruct x: 0, y: 0, z: 0, directions: [], max_distance: 0

  def steps_away(input) do
    input
    |> parse
    |> process_recursively
    |> distance_from
  end

  def furthest_away(input) do
    input
    |> parse
    |> process_recursively
    |> Map.get(:max_distance)
  end

  def process_recursively(%{directions: []} = state), do: state

  def process_recursively(state) do
    state
    |> process
    |> process_recursively
  end

  def process(%{directions: [direction | tail], x: x, y: y, z: z} = state) do
    {x2, y2, z2} = travel(direction, {x, y, z})
    next_state = %{state | x: x2, y: y2, z: z2}

    distance = distance_from(next_state)
    max_distance = Enum.max([state.max_distance, distance])

    %{next_state | directions: tail, max_distance: max_distance}
  end

  def travel(:north, {x, y, z}), do: {x, y + 1, z - 1}
  def travel(:north_east, {x, y, z}), do: {x + 1, y, z - 1}
  def travel(:north_west, {x, y, z}), do: {x - 1, y + 1, z}
  def travel(:south, {x, y, z}), do: {x, y - 1, z + 1}
  def travel(:south_east, {x, y, z}), do: {x + 1, y - 1, z}
  def travel(:south_west, {x, y, z}), do: {x - 1, y, z + 1}

  def parse(input) do
    directions =
      input
      |> String.split(",")
      |> Enum.map(&direction_to_atom/1)

    %__MODULE__{directions: directions}
  end

  defp direction_to_atom("n"), do: :north
  defp direction_to_atom("ne"), do: :north_east
  defp direction_to_atom("nw"), do: :north_west
  defp direction_to_atom("s"), do: :south
  defp direction_to_atom("se"), do: :south_east
  defp direction_to_atom("sw"), do: :south_west

  defp distance_from(current_position, other_position \\ {0, 0, 0})

  defp distance_from(%{x: x1, y: y1, z: z1}, {x2, y2, z2}) do
    Enum.max([abs(x2 - x1), abs(y2 - y1), abs(z2 - z1)])
  end
end
