defmodule Adventofcode.Day09StreamProcessing do
  def total_score(input) do
    input
    |> process
    |> elem(0)
  end

  def garbage_score(input) do
    input
    |> process
    |> elem(1)
  end

  def process(input, level \\ 0, score \\ 0, garbage \\ false, garbage_score \\ 0)

  def process("", _, score, _, garbage_score), do: {score, garbage_score}

  def process("{" <> input, level, score, false, garbage_score) do
    process(input, level + 1, score, false, garbage_score)
  end

  def process("}" <> input, level, score, false, garbage_score) do
    process(input, level - 1, score + level, false, garbage_score)
  end

  def process("<" <> input, level, score, false, garbage_score) do
    process(input, level, score, true, garbage_score)
  end

  def process("," <> input, level, score, false, garbage_score) do
    process(input, level, score, false, garbage_score)
  end

  def process("!" <> input, level, score, true, garbage_score) do
    process(skip(input), level, score, true, garbage_score)
  end

  def process(">" <> input, level, score, true, garbage_score) do
    process(input, level, score, false, garbage_score)
  end

  def process(input, level, score, true, garbage_score) do
    process(skip(input), level, score, true, garbage_score + 1)
  end

  defp skip(input), do: String.slice(input, 1..-1)
end
