defmodule Adventofcode.Day03SpiralMemory do
  require Integer

  def steps_to_access_port(input) when is_binary(input) do
    steps_to_access_port(String.to_integer(input))
  end

  def steps_to_access_port(1), do: 0

  def steps_to_access_port(value) when is_number(value) do
    circle = get_inner_circle(value)
    smaller_area = :math.pow(circle, 2) |> round()
    bigger_area = :math.pow(circle + 2, 2) |> round()
    diff_area = (bigger_area - smaller_area) |> round()
    side_len = (diff_area / 4) |> Float.floor() |> round()
    len = rem(value - smaller_area - 1, side_len)
    mid = (side_len / 2 - 1) |> Float.floor() |> round()
    out_steps = ((circle + 1) / 2) |> Float.floor() |> round()

    cond do
      len == mid -> out_steps
      len < mid -> out_steps + mid - len
      len > mid -> out_steps + len - mid
    end
  end

  defp get_inner_circle(value) do
    rounded_sqrt = :math.pow(value - 1, 1 / 2) |> Float.floor() |> round()
    if Integer.is_even(rounded_sqrt), do: rounded_sqrt - 1, else: rounded_sqrt
  end
end
