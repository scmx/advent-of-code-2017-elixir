defmodule Adventofcode.Day24ElectromagneticMoat do
  def strongest_bridge(input) do
    input
    |> parse()
    |> build_bridges()
    |> Enum.map(&sum_bridge/1)
    |> Enum.max()
  end

  def longest_bridge(input) do
    input
    |> parse()
    |> build_bridges()
    |> longest_bridges()
    |> Enum.map(&sum_bridge/1)
    |> Enum.max()
  end

  defp parse(input) do
    ~r/(\d+)\/(\d+)/
    |> Regex.scan(input)
    |> Enum.map(&parse_component/1)
  end

  defp parse_component([_, a, b]) do
    {String.to_integer(a), String.to_integer(b)}
  end

  defp build_bridges(components_left, bridge \\ [], current \\ 0)

  defp build_bridges([], bridge, _current), do: bridge

  defp build_bridges(components_left, bridge, current) do
    case find_indexes(components_left, current) do
      [] -> [bridge]
      indexes -> do_build_bridges(components_left, bridge, current, indexes)
    end
  end

  defp do_build_bridges(components_left, bridge, current, indexes) do
    Enum.flat_map(indexes, fn index ->
      {component, rest} = List.pop_at(components_left, index)
      next = next_connector(component, current)
      build_bridges(rest, [component | bridge], next)
    end)
  end

  defp find_indexes(components_left, current) do
    Enum.reduce(Enum.with_index(components_left), [], fn
      {{^current, _}, index}, acc -> [index | acc]
      {{_, ^current}, index}, acc -> [index | acc]
      _, acc -> acc
    end)
  end

  defp next_connector({current, b}, current), do: b
  defp next_connector({a, current}, current), do: a

  defp sum_bridge(components) do
    components
    |> Enum.flat_map(&Tuple.to_list/1)
    |> Enum.sum()
  end

  defp longest_bridges([first_bridge | bridges]) do
    Enum.reduce(bridges, [first_bridge], fn bridge, acc ->
      case {length(bridge), length(hd(acc))} do
        {a, b} when a > b -> [bridge]
        {a, b} when a == b -> [bridge | acc]
        _ -> acc
      end
    end)
  end
end
