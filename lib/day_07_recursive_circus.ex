defmodule Adventofcode.Day07RecursiveCircus do
  defstruct name: nil, weight: nil, children: [], parent: nil, total_weight: 0

  def bottom_program(input) do
    input
    |> parse()
    |> start_programs()
    |> connect_programs()
    |> find_bottom_and_stop_programs()
  end

  def unbalanced_weight(input) do
    input
    |> parse()
    |> start_programs()
    |> connect_programs()
    |> find_unbalanced_weight_and_stop_programs()
  end

  defp start_programs(programs) do
    Enum.reduce(programs, %{}, fn {program_name, program_state}, acc ->
      {:ok, pid} = Agent.start_link(fn -> program_state end)
      Map.put(acc, program_name, pid)
    end)
  end

  defp connect_programs(programs) do
    programs
    |> Map.values()
    |> Enum.map(&set_children_pids(&1, programs))
    |> Enum.map(&set_parent_pids(&1, programs))
  end

  defp set_children_pids(pid, programs) do
    Agent.update(pid, fn program ->
      children =
        Enum.reduce(program.children, %{}, fn child, acc ->
          Map.put(acc, child, Map.get(programs, child))
        end)

      %{program | children: children}
    end)

    pid
  end

  defp set_parent_pids(pid, programs) do
    Agent.update(pid, fn program ->
      parent =
        programs
        |> Map.values()
        |> Enum.reject(&(&1 == pid))
        |> Enum.find(&parent_of(&1, pid))

      %{program | parent: parent}
    end)

    pid
  end

  defp parent_of(program_pid, target_pid) do
    Agent.get(program_pid, &(target_pid in Map.values(&1.children)))
  end

  defp find_bottom_and_stop_programs([pid | _] = programs) do
    program = find_bottom(pid)
    Enum.each(programs, &Agent.stop/1)
    program.name
  end

  defp find_unbalanced_weight_and_stop_programs([pid | _] = programs) do
    bottom_program = find_bottom(pid)
    weight = find_unbalanced_program(bottom_program)
    Enum.each(programs, &Agent.stop/1)
    weight
  end

  defp find_unbalanced_program(program, expected_weight \\ nil) do
    case grouped_weights(program.children) do
      [{_unbalanced_weight, [child]}, {expected_weight, _}] ->
        find_unbalanced_program(child, expected_weight)

      [{_balanced_weight, _children}] ->
        expected_weight - program.total_weight + program.weight
    end
  end

  def grouped_weights([]), do: nil

  def grouped_weights(children) do
    children
    |> Map.values()
    |> Enum.map(&Agent.get(&1, fn p -> p end))
    |> Enum.map(&%{&1 | total_weight: get_total_weight(&1)})
    |> Enum.group_by(& &1.total_weight)
    |> Enum.sort_by(fn {_, programs} -> length(programs) end)
  end

  def get_total_weight(program) do
    children_weight =
      program.children
      |> Map.values()
      |> Enum.map(&Agent.get(&1, fn p -> p end))
      |> Enum.map(&get_total_weight/1)
      |> Enum.sum()

    program.weight + children_weight
  end

  defp find_bottom(pid) do
    program = Agent.get(pid, & &1)

    case program do
      %{parent: nil} -> program
      %{parent: pid} -> find_bottom(pid)
    end
  end

  defp parse(input) do
    input
    |> String.trim_trailing()
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
    |> Enum.map(&{&1.name, &1})
    |> Enum.into(%{})
  end

  defp parse_line(line) do
    ~r/(?<name>\w+)\s+\((?<weight>\w+)\)(?:\s+\-\>\s+(?<children>[\w,\s]+))?/
    |> Regex.named_captures(line)
    |> build_struct()
  end

  defp parse_children(""), do: []
  defp parse_children(data), do: String.split(data, ", ")

  defp build_struct(%{"name" => name, "weight" => weight, "children" => children}) do
    weight = String.to_integer(weight)
    %__MODULE__{name: name, weight: weight, children: parse_children(children)}
  end
end
