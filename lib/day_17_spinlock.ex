defmodule Adventofcode.Day17Spinlock do
  @enforce_keys [:steps]
  defstruct circular_buffer: [0], length: 1, current_index: 0, next: 1, last: 2017, steps: nil

  def value_after_last(input, iterations \\ 2017) do
    state = input |> new(iterations) |> step_until_last() |> forward(1)
    Enum.at(state.circular_buffer, state.current_index)
  end

  def value_after_zero(input, iterations \\ 50_000_000) do
    state = input |> new(iterations) |> step_until_last()
    index = Enum.find_index(state.circular_buffer, &(&1 == 0))
    state = forward(%{state | current_index: index}, 1)
    Enum.at(state.circular_buffer, state.current_index)
  end

  def new(input, last) when is_binary(input) do
    new(String.to_integer(input), last)
  end

  def new(steps, last) do
    %__MODULE__{steps: steps, last: last}
  end

  def step_until_last(%{next: next, last: last} = state) when next > last do
    state
  end

  def step_until_last(state) do
    state |> step() |> step_until_last()
  end

  def step(state) do
    if rem(state.next, 10_000) == 0 do
      IO.inspect(Map.split(state, [:circular_buffer]) |> elem(1))
    end

    state
    |> forward(state.steps)
    |> insert_next()
    |> increment_values()
    |> forward(1)
  end

  defp forward(state, steps) do
    %{state | current_index: rem(state.current_index + steps, state.length)}
  end

  defp insert_next(%{circular_buffer: buffer, current_index: index} = state) do
    %{state | circular_buffer: List.insert_at(buffer, index + 1, state.next)}
  end

  defp increment_values(state) do
    %{state | length: state.length + 1, next: state.next + 1}
  end
end
