defmodule Adventofcode.Day12DigitalPlumber do
  def how_many_programs(input) do
    input
    |> parse
    |> which_programs
    |> length()
  end

  def how_many_groups(input) do
    input
    |> parse()
    |> which_groups()
    |> Map.keys()
    |> length()
  end

  def which_groups(programs, initial \\ 0, groups \\ %{}) do
    groups = Map.put(groups, initial, which_programs(programs, initial))
    all = programs |> Map.keys()
    collected = groups |> Map.values() |> List.flatten() |> Enum.uniq()

    case all -- collected do
      [] -> groups
      [initial | _tail] -> which_groups(programs, initial, groups)
    end
  end

  def which_programs(programs, initial \\ 0) do
    programs
    |> do_travel([initial], MapSet.new([initial]))
    |> Enum.to_list()
  end

  def parse(input) do
    input
    |> String.trim_trailing()
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
    |> Enum.into(%{})
  end

  defp parse_line(line) do
    [program, connections] = ~r/(\d+) <-> ([\d, ]+)/ |> Regex.run(line) |> tl

    connections = connections |> String.split(", ") |> Enum.map(&String.to_integer/1)
    {String.to_integer(program), connections}
  end

  defp do_travel(programs, ids, collected) do
    case collect_connections(programs, ids, collected) do
      {_ids, ^collected} -> collected
      {ids, collected} -> do_travel(programs, ids, collected)
    end
  end

  defp collect_connections(programs, ids, collected) do
    ids =
      ids
      |> Enum.flat_map(&Map.get(programs, &1))
      |> Enum.reject(&(&1 in collected))

    collected = Enum.reduce(ids, collected, &MapSet.put(&2, &1))
    {ids, collected}
  end
end
