defmodule Adventofcode.Day18Duet do
  alias Adventofcode.Day18Duet.RecoveredFrequency

  defdelegate recovered_frequency_value(input), to: RecoveredFrequency
end
