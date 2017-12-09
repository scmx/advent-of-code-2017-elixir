defmodule Adventofcode.Day09StreamProcessing do
  def total_score(input) do
    input
    |> process
  end

  def process(input, level \\ 0, score \\ 0, garbage \\ false)

  def process("", _, score, _), do: score

  def process("{" <> input, level, score, false) do
    process(input, level + 1, score, false)
  end

  def process("}" <> input, level, score, false) do
    process(input, level - 1, score + level, false)
  end

  def process("<" <> input, level, score, false) do
    process(input, level, score, true)
  end

  def process("," <> input, level, score, false) do
    process(input, level, score, false)
  end

  def process("!" <> input, level, score, true) do
    process(skip(input), level, score, true)
  end

  def process(">" <> input, level, score, true) do
    process(input, level, score, false)
  end

  def process(input, level, score, true) do
    process(skip(input), level, score, true)
  end

  defp skip(input), do: String.slice(input, 1..-1)
end
