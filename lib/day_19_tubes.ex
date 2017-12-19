defmodule Adventofcode.Day19Tubes do
  defstruct grid: nil,
            width: 0,
            height: 0,
            seen: [],
            position: {0, 0},
            direction: {0, 1}

  def what_letters(input) do
    input
    |> new()
    |> travel()
    |> seen_letters()
  end

  defp new(input) do
    starting_pos = {index_of_first_pipe(input), 0}
    lines = String.split(input, "\n")
    width = lines |> Enum.map(&String.length/1) |> Enum.max()
    height = length(lines)
    chars = Enum.flat_map(lines, &String.codepoints/1)

    %__MODULE__{
      grid: build_grid(chars, width),
      width: width,
      height: height,
      position: starting_pos
    }
  end

  defp travel(state) do
    char = state.grid[state.position]

    case char do
      " " ->
        state

      nil ->
        state

      "|" ->
        state |> forward() |> travel()

      "-" ->
        state |> forward() |> travel()

      "+" ->
        state |> turn() |> forward() |> travel()

      letter ->
        state |> store_letter(letter) |> forward() |> travel()
    end
  end

  defp forward(state) do
    %{state | position: next_pos(state.position, state.direction)}
  end

  defp next_pos({x, y}, {dir_x, dir_y}) do
    {x + dir_x, y + dir_y}
  end

  defp store_letter(state, letter) do
    %{state | seen: [letter | state.seen]}
  end

  defp turn(state) do
    case state.direction do
      {_, 0} -> state |> do_turn([{0, -1}, {0, 1}])
      {0, _} -> state |> do_turn([{-1, 0}, {1, 0}])
    end
  end

  defp do_turn(state, directions) do
    %{state | direction: next_direction(state, directions)}
  end

  defp next_direction(state, directions) do
    Enum.find(directions, fn direction ->
      position = next_pos(state.position, direction)

      case state.grid[position] do

        " " ->
          false

        _ ->
          true
      end
    end)
  end

  defp build_grid(chars, width) do
    Enum.reduce(Enum.with_index(chars), %{}, fn {char, index}, acc ->
      x = rem(index, width)
      y = div(index, width)

      Map.put(acc, {x, y}, char)
    end)
  end

  defp index_of_first_pipe(input) do
    input |> String.codepoints() |> Enum.find_index(&(&1 == "|"))
  end

  defp seen_letters(state) do
    state
    |> Map.get(:seen)
    |> Enum.reverse()
    |> Enum.join()
  end
end
