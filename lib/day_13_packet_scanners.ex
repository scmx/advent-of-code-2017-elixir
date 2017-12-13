defmodule Adventofcode.Day13PacketScanners do
  alias Scanner

  @enforce_keys [:scanners, :max_depth]
  defstruct scanners: nil, max_depth: nil, depth: -1, caught_at_depth: []

  def severity(input) do
    input
    |> parse()
    |> new()
    |> tick_repeatedly()
    |> do_severity()
  end

  defp do_severity(%{caught_at_depth: caught_at_depth, scanners: scanners}) do
    scanners
    |> Enum.filter(&(&1.depth in caught_at_depth))
    |> Enum.map(&(&1.depth * &1.range))
    |> Enum.sum()
  end

  defp tick_repeatedly(%{depth: max_depth, max_depth: max_depth} = state), do: state

  defp tick_repeatedly(state) do
    state
    |> tick()
    |> tick_repeatedly()
  end

  defp tick(state) do
    state
    |> tick_player()
    |> tick_scanners()
  end

  defmodule Scanner do
    @enforce_keys [:depth, :range]
    defstruct depth: nil, range: nil, position: 0, direction: 1
  end

  defp tick_player(%{depth: depth, scanners: scanners} = state) do
    depth = depth + 1

    caught_at_depth =
      case Enum.find(scanners, &(&1.depth == depth and &1.position == 0)) do
        nil -> state.caught_at_depth
        _scanner -> state.caught_at_depth ++ [depth]
      end

    %{state | depth: depth, caught_at_depth: caught_at_depth}
  end

  defp tick_scanners(%{scanners: scanners} = state) do
    %{state | scanners: Enum.map(scanners, &tick_scanner/1)}
  end

  defp tick_scanner(%{position: pos, direction: dir, range: range} = scanner) do
    direction =
      cond do
        pos + dir < 0 -> 1
        pos + dir >= range -> -1
        true -> dir
      end

    %{scanner | position: pos + direction, direction: direction}
  end

  defp new(scanners) do
    max_depth = scanners |> Enum.map(& &1.depth) |> Enum.max()

    %__MODULE__{scanners: scanners, max_depth: max_depth}
  end

  defp parse(input) do
    input
    |> String.trim_trailing()
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
    |> Enum.map(fn [depth, range] -> %Scanner{depth: depth, range: range} end)
  end

  defp parse_line(line) do
    line
    |> String.split(": ")
    |> Enum.map(&String.to_integer/1)
  end
end
