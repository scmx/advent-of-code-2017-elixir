defmodule Adventofcode.Day14DiskDefragmentation do
  alias Adventofcode.Day10KnotHash

  def squares_count(input) do
    input
    |> squares()
    |> Enum.map(&used_square_count/1)
    |> Enum.sum()
  end

  def regions_count(input) do
    input
    |> regions()
    |> length()
  end

  def regions(input) do
    input
    |> squares()
    |> free_squares_to_coordinates()
    |> group_coordinates()
  end

  defp squares(input) do
    0..127
    |> Enum.map(&"#{input}-#{&1}")
    |> Enum.map(&Day10KnotHash.knot_hash/1)
    |> Enum.map(&convert_hash_to_bits/1)
  end

  defp free_squares_to_coordinates(squares) do
    Enum.flat_map(Enum.with_index(squares), fn {line, y} ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.filter(fn {char, _} -> char == "1" end)
      |> Enum.map(fn {_, x} -> {x, y} end)
    end)
  end

  defp group_coordinates(coordinates, groups \\ [])
  defp group_coordinates([], groups), do: groups

  defp group_coordinates([{x, y} | coordinates], groups) do
    {group, coordinates} = do_group_coordinates(MapSet.new([{x, y}]), coordinates)
    group_coordinates(coordinates, [group | groups])
  end

  defp do_group_coordinates(group, coordinates) do
    case take_neighbours(group, coordinates) do
      {^group, coordinates} -> {group, coordinates}
      {group, coordinates} -> do_group_coordinates(group, coordinates)
    end
  end

  def take_neighbours(group, coordinates) do
    neighbours =
      group
      |> Enum.flat_map(&neighbour_coordinates/1)
      |> Enum.filter(&(&1 in coordinates))
      |> Enum.reject(&(&1 in group))

    group = MapSet.union(MapSet.new(group), MapSet.new(neighbours))
    coordinates = Enum.reject(coordinates, &(&1 in group))
    {group, coordinates}
  end

  def neighbour_coordinates({x, y}) do
    [{x - 1, y}, {x + 1, y}, {x, y + 1}, {x, y - 1}]
    |> Enum.filter(fn {x, y} -> x >= 0 and x <= 127 and y >= 0 and y <= 127 end)
  end

  defp convert_hash_to_bits(hex_hash) do
    hex_hash
    |> String.graphemes()
    |> Enum.map(&convert_hex_digit_to_bits/1)
    |> Enum.join()
  end

  defp convert_hex_digit_to_bits(hex_digit) do
    hex_digit
    |> String.to_integer(16)
    |> Integer.to_string(2)
    |> String.pad_leading(4, "0")
  end

  defp used_square_count(line) do
    line
    |> String.graphemes()
    |> Enum.filter(&(&1 == "1"))
    |> Enum.count()
  end

  def pretty_print(regions) do
    coordinates =
      regions
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {coordinates, index}, acc ->
           Enum.reduce(coordinates, acc, &Map.put(&2, &1, index))
         end)

    Enum.map_join(0..127, "\n", fn y ->
      Enum.map_join(0..127, "", fn x ->
        case coordinates[{x, y}] do
          nil -> "  "
          group -> Integer.to_string(group, 36)
        end
      end)
    end)
  end
end
