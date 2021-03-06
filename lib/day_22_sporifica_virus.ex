defmodule Adventofcode.Day22SporificaVirus do
  use Adventofcode

  @enforce_keys [:grid, :width, :height, :burst]
  defstruct grid: MapSet.new(),
            width: 0,
            height: 0,
            position: {0, 0},
            direction: {0, -1},
            burst: {0, nil},
            infections: 0

  def bursts_infected_count(input, bursts) do
    input
    |> new(bursts)
    |> burst_repeatedly()
    |> Map.get(:infections)
  end

  def new(input, bursts) do
    lines = String.split(input, "\n")
    width = lines |> Enum.map(&String.length/1) |> Enum.max()
    height = length(lines)
    chars = Enum.flat_map(lines, &String.codepoints/1)

    %__MODULE__{
      grid: build_grid(chars, width),
      width: width,
      height: height,
      burst: {0, bursts}
    }
  end

  def burst_repeatedly(state, options \\ [])

  def burst_repeatedly(%{burst: {burst, burst}} = state, _) do
    state
  end

  def burst_repeatedly(state, options) do
    state
    |> turn_left_or_right()
    |> toggle_infected()
    |> forward()
    |> print_and_sleep(options)
    |> burst_repeatedly(options)
  end

  defp forward(%{burst: {burst, last_burst}} = state) do
    position = next_pos(state.position, state.direction)
    %{state | position: position, burst: {burst + 1, last_burst}}
  end

  defp next_pos({x, y}, {dir_x, dir_y}) do
    {x + dir_x, y + dir_y}
  end

  @directions [{1, 0}, {0, 1}, {-1, 0}, {0, -1}]
  defp turn_left_or_right(state) do
    index = Enum.find_index(@directions, &(&1 == state.direction))
    diff = if position_infected?(state), do: 1, else: -1
    next_index = rem(index + diff, length(@directions))
    direction = Enum.at(@directions, next_index)
    %{state | direction: direction}
  end

  defp toggle_infected(%{position: position, infections: infections} = state) do
    if position_infected?(state) do
      %{state | grid: MapSet.delete(state.grid, position)}
    else
      %{state | grid: MapSet.put(state.grid, position), infections: infections + 1}
    end
  end

  defp position_infected?(state), do: position_infected?(state, state.position)

  defp position_infected?(state, position) do
    MapSet.member?(state.grid, position)
  end

  defp build_grid(chars, width) do
    x_offset = div(width, 2)
    y_offset = div(width, 2)

    Enum.reduce(Enum.with_index(chars), MapSet.new(), fn
      {".", _index}, acc ->
        acc

      {"#", index}, acc ->
        x = rem(index, width) - x_offset
        y = div(index, width) - y_offset

        MapSet.put(acc, {x, y})
    end)
  end

  defp print_and_sleep(state, options) do
    if Keyword.get(options, :print), do: print_pretty_grid(state)
    if sleep = Keyword.get(options, :sleep), do: :timer.sleep(sleep)
    state
  end

  def print_pretty_grid(state) do
    IO.puts(IO.ANSI.reset() <> IO.ANSI.home() <> IO.ANSI.clear() <> pretty_grid(state))
  end

  def pretty_grid(%{position: position} = state, range \\ -20..20) do
    print_cell = fn {x, y} ->
      if position_infected?(state, {x, y}), do: "#", else: "."
    end

    Enum.map_join(range, "\n", fn y ->
      Enum.map_join(range, "", fn x ->
        cond do
          Enum.min(range) == x -> ""
          position == {x, y} -> "["
          position == {x - 1, y} -> "]"
          true -> " "
        end <> print_cell.({x, y})
      end)
    end) <> "\n"
  end
end
