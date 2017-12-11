defmodule Adventofcode.Day09StreamProcessing do
  defstruct level: 0, score: 0, garbage: false, garbage_score: 0

  def total_score(input), do: process(input).score

  def garbage_score(input), do: process(input).garbage_score

  def process(input, state \\ %__MODULE__{})

  def process("", state), do: state

  def process("{" <> input, %{garbage: false} = state) do
    process(input, %{state | level: state.level + 1})
  end

  def process("}" <> input, %{garbage: false} = s) do
    process(input, %{s | level: s.level - 1, score: s.score + s.level})
  end

  def process("<" <> input, %{garbage: false} = state) do
    process(input, %{state | garbage: true})
  end

  def process("," <> input, %{garbage: false} = state) do
    process(input, state)
  end

  def process("!" <> <<_::binary-size(1)>> <> input, %{garbage: true} = state) do
    process(input, state)
  end

  def process(">" <> input, %{garbage: true} = state) do
    process(input, %{state | garbage: false})
  end

  def process(<<_::binary-size(1)>> <> input, %{garbage: true} = state) do
    process(input, %{state | garbage_score: state.garbage_score + 1})
  end
end
