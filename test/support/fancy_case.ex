defmodule Adventofcode.FancyCase do
  @moduledoc """
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      import Adventofcode.FancyCase
    end
  end

  setup _tags do
    :ok
  end

  @doc """
  Helper for running tests against puzzle input files.

  Runs the given function with the contents of the file if it exists.
  """
  def with_puzzle_input(path, options \\ [], fun) do
    trim =
      if Keyword.get(options, :trim) == false do
        &String.trim_trailing(&1, "\n")
      else
        &String.trim/1
      end

    case path |> File.read() do
      {:ok, data} -> data |> trim.() |> fun.()
      {:error, _} -> nil
    end
  end

  @doc """
  Custom sigil that scans for and returns a list of found integers.

      iex> import Adventofcode.FancyCase
      ...> ~i"32 5 10"
      [32, 5, 10]
  """
  def sigil_i(data, []) do
    ~r/\d+/
    |> Regex.scan(data)
    |> List.flatten()
    |> Enum.map(&String.to_integer/1)
  end
end
