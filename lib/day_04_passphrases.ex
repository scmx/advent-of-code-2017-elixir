defmodule Adventofcode.Day04Passphrases do
  def valid_count(input) do
    input
    |> parse
    |> Enum.map(&validate_each/1)
    |> count_valid_lines
  end

  def valid_count_anagram(input) do
    input
    |> parse
    |> Enum.map(&validate_each_anagram/1)
    |> count_valid_lines
  end

  defp parse(input) do
    input
    |> String.trim_trailing()
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(input) do
    input
    |> String.split(" ")
  end

  defp validate_each(line) do
    validity = Enum.uniq(line) == line

    {validity, line}
  end

  def validate_each_anagram(line) do
    phrases = Enum.map(line, &sort_word/1)

    validity = Enum.uniq(phrases) == phrases

    {validity, line}
  end

  defp count_valid_lines(lines) do
    lines
    |> Enum.filter(&elem(&1, 0))
    |> Enum.count()
  end

  defp sort_word(word) do
    word
    |> String.split("", trim: true)
    |> Enum.sort()
    |> Enum.join("")
  end
end
