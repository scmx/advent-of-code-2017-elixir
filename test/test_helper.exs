ExUnit.start()

defmodule Adventofcode.TestHelpers do
  def with_puzzle_input(path, fun) do
    case path |> File.read() do
      {:ok, data} -> fun.(data |> String.trim())
      {:error, _} -> nil
    end
  end
end
