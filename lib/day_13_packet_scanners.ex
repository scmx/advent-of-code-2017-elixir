defmodule Adventofcode.Day13PacketScanners do
  alias Scanner

  @enforce_keys [:scanners, :max_depth]
  defstruct scanners: nil, max_depth: nil, depth: -1, caught_at_depth: [], delay: 0

  def severity(input) do
    input
    |> parse()
    |> new()
    |> tick_repeatedly()
    |> do_severity()
  end

  def minimum_delay(input) do
    input
    |> parse()
    |> new()
    |> do_minimum_delay()
  end

  defp do_severity(%{caught_at_depth: caught_at_depth, scanners: scanners}) do
    scanners
    |> Enum.filter(&(&1.depth in caught_at_depth))
    |> Enum.map(&(&1.depth * &1.range))
    |> Enum.sum()
  end

  defp do_minimum_delay(state) do
    Enum.find_value(Stream.iterate(0, &(&1 + 1)), fn delay ->
      case %{state | delay: delay} |> tick_until_caught_or_done() do
        %{caught_at_depth: []} -> delay
        %{caught_at_depth: [_depth]} -> nil
      end
    end)
  end

  defp tick_repeatedly(%{depth: max_depth, max_depth: max_depth} = state), do: state

  defp tick_repeatedly(state) do
    state
    |> tick()
    |> tick_repeatedly()
  end

  defp tick_until_caught_or_done(%{caught_at_depth: [_ | _]} = state), do: state

  defp tick_until_caught_or_done(%{depth: max_depth, max_depth: max_depth} = state) do
    state
  end

  defp tick_until_caught_or_done(state) do
    state
    |> tick()
    |> tick_until_caught_or_done()
  end

  defp tick(%{delay: 0} = state) do
    state
    |> tick_player()
    |> tick_scanners()
  end

  defp tick(%{delay: delay} = state) do
    %{state | delay: 0}
    |> fastforward_scanners(delay)
    |> tick()
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

  defp fastforward_scanners(%{scanners: scanners} = state, delay) do
    %{state | scanners: Enum.map(scanners, &fastforward_scanner(&1, delay))}
  end

  defp fastforward_scanner(scanner, delay) do
    distance = scanner.range - 1

    case rem(scanner.position + delay, distance * 2) do
      pos when pos > distance ->
        %{scanner | direction: -1, position: trunc(abs(distance * 2 - pos))}

      pos ->
        %{scanner | direction: 1, position: pos}
    end
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
