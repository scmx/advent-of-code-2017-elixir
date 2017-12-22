defmodule Mix.Tasks.Day do
  def run(["22.1"]) do
    import Adventofcode.Day22SporificaVirus

    puzzle_input()
    |> new(10000)
    |> burst_repeatedly(sleep: 10, print: true)
  end
end
