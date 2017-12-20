defmodule Adventofcode.Day20ParticleSwarmTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day20ParticleSwarm

  describe "closest_particle_long_term/1" do
    @input """
    p=< 3,0,0>, v=< 2,0,0>, a=<-1,0,0>
    p=< 4,0,0>, v=< 0,0,0>, a=<-2,0,0>
    """
    test "determines the closest particle" do
      assert 0 = @input |> closest_particle_long_term()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_20_particle_swarm.txt", fn input ->
        assert 457 = input |> closest_particle_long_term()
      end)
    end
  end

  describe "particles_left_count/1" do
    @input """
    p=<-6,0,0>, v=< 3,0,0>, a=< 0,0,0>
    p=<-4,0,0>, v=< 2,0,0>, a=< 0,0,0>
    p=<-2,0,0>, v=< 1,0,0>, a=< 0,0,0>
    p=< 3,0,0>, v=<-1,0,0>, a=< 0,0,0>
    """
    test "counts the particles left after all collisions are resolved" do
      assert 1 = @input |> particles_left_count()
    end

    test "with puzzle input" do
      with_puzzle_input("input/day_20_particle_swarm.txt", fn input ->
        assert 448 = input |> particles_left_count()
      end)
    end
  end
end
