require 'pry'
require 'colorize'
require_relative '../individual'

module Problems
  class Base
    def initialize(offset:, scale:, log_scale: nil)
      @offset = offset
      @scale = scale
      @log_scale = log_scale
    end

    attr_reader :offset, :scale, :log_scale, :individuals_by_fitness

    def population_size
      individuals_by_fitness.length
    end

    def best
      individuals_by_fitness.last
    end

    def worst
      individuals_by_fitness.first
    end

    def average_fitness
      individuals_by_fitness.map(&:fitness).mean
    end

    def penality(_individual)
      0
    end

    def update_individuals!(new_individuals, generation, keep: nil)
      individuals = new_individuals.map do |individual|
        Individual.new(self, individual, generation)
      end
      @individuals_by_fitness = individuals.sort_by(&:fitness)

      if keep
        individuals = @individuals_by_fitness.drop(1)
        keep.reset_fitness!
        individuals << keep
        @individuals_by_fitness = individuals.sort_by(&:fitness)
      end

      @individuals_by_fitness
    end

    def reset_individuals!
      @individuals_by_fitness = new_population.sort_by(&:fitness)
    end
  end
end
