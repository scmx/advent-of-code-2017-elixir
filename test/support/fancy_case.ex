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
  def with_puzzle_input(path, fun) do
    case path |> File.read() do
      {:ok, data} -> fun.(data |> String.trim())
      {:error, _} -> nil
    end
  end
end
