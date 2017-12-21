defmodule Adventofcode.Day21FractalArt do
  @enforce_keys [:enhancement_rules, :iteration]
  defstruct grid: ~w(.#. ..# ###),
            size: 3,
            enhancement_rules: nil,
            iteration: nil

  def pixels_left_on_count(input, iterations) do
    input
    |> new(iterations)
    |> iterate()
    |> do_pixels_on_count()
  end

  defp new(input, iterations) do
    %__MODULE__{enhancement_rules: parse(input), iteration: {0, iterations}}
  end

  defp iterate(%{iteration: {current, current}} = state), do: state

  defp iterate(state) do
    state
    |> enhance()
    |> update_size()
    |> increment_iteration()
    |> iterate()
  end

  defp enhance(%{size: size} = state) when size >= 4 and rem(size, 2) == 0 do
    state.grid
    |> chunk_grid(2)
    |> Enum.map(fn row -> Enum.map(row, &do_enhance(&1, state)) end)
    |> combine_grids(state)
  end

  defp enhance(%{size: size} = state) when size >= 6 and rem(size, 3) == 0 do
    state.grid
    |> chunk_grid(3)
    |> Enum.map(fn row -> Enum.map(row, &do_enhance(&1, state)) end)
    |> combine_grids(state)
  end

  defp enhance(state) do
    %{state | grid: do_enhance(state.grid, state)}
  end

  defp do_enhance(grid, state) do
    variants = variants(grid)

    Enum.find_value(state.enhancement_rules, fn {pattern, result} ->
      Enum.find_value(variants, &(&1 == pattern)) && result
    end)
  end

  defp variants(grid) do
    Enum.uniq([
      grid,
      grid |> rotate(),
      grid |> flip(),
      grid |> flip() |> rotate(),
      grid |> rotate() |> flip(),
      grid |> rotate() |> flip() |> rotate(),
      grid |> flip() |> rotate() |> flip(),
      grid |> flip() |> rotate() |> flip() |> rotate()
    ])
  end

  def rotate(grid) do
    grid
    |> Enum.map(&String.graphemes/1)
    |> transpose()
    |> Enum.map(&Enum.join/1)
  end

  def flip(grid) do
    Enum.reverse(grid)
  end

  def transpose(list) do
    list
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  defp chunk_grid(grid, size) do
    chunked = Enum.chunk_every(grid, size)

    Enum.map(chunked, fn row ->
      row
      |> Enum.map(&String.graphemes/1)
      |> Enum.map(&Enum.chunk_every(&1, size))
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(fn l -> Enum.map(l, &Enum.join/1) end)
    end)
  end

  defp combine_grids(grids, state) do
    %{state | grid: do_combine_grids(grids)}
  end

  defp do_combine_grids(grids) do
    Enum.flat_map(grids, fn row ->
      row
      |> transpose()
      |> Enum.map(&Enum.join/1)
    end)
  end

  defp update_size(state) do
    %{state | size: state.grid |> hd() |> String.length()}
  end

  defp increment_iteration(%{iteration: {current, last}} = state) do
    %{state | iteration: {current + 1, last}}
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_pattern/1)
    |> Enum.into(%{})
  end

  defp parse_pattern(pattern) do
    pattern
    |> String.split(" => ")
    |> Enum.map(&String.split(&1, "/"))
    |> List.to_tuple()
  end

  defp do_pixels_on_count(%{grid: grid}) do
    grid
    |> Enum.flat_map(&String.graphemes/1)
    |> Enum.filter(&(&1 == "#"))
    |> length()
  end
end
