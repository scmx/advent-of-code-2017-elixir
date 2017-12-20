defmodule Adventofcode.Day20ParticleSwarm do
  def closest_particle_long_term(input) do
    particles = parse(input)

    1..1_000
    |> Enum.reduce(particles, fn _, acc -> tick(acc) end)
    |> Enum.map(&manhattan_distance/1)
    |> closest_particle()
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    ~r/(\w+)=<([\-\ ]?\w+),([\-\ ]?\w+),([\-\ ]?\w+)>/
    |> Regex.scan(line)
    |> Enum.map(&tl/1)
    |> Enum.map(&parse_values/1)
    |> Enum.into(%{})
  end

  defp parse_values([name | tail]) do
    values =
      tail
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()

    {String.to_atom(name), values}
  end

  defp tick(particles) do
    particles |> Enum.map(&tick_particle/1)
  end

  defp tick_particle(%{p: {px, py, pz}, v: {vx, vy, vz}, a: {ax, ay, az}}) do
    vx = vx + ax
    vy = vy + ay
    vz = vz + az
    %{p: {px + vx, py + vy, pz + vz}, v: {vx, vy, vz}, a: {ax, ay, az}}
  end

  defp manhattan_distance(%{p: {x, y, z}}) do
    [x, y, z] |> Enum.map(&abs/1) |> Enum.sum()
  end

  defp closest_particle(distances) do
    distances
    |> Enum.with_index()
    |> Enum.sort_by(fn {distance, _} -> distance end)
    |> hd()
    |> elem(1)
  end
end
