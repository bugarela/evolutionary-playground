require 'pry'
require 'colorize'
require_relative '../individual'

module Problems
  class Base
    def initialize(individuals, offset:, scale:)
      @offset = offset
      @scale = scale
      @individuals_by_fitness = individuals.sort_by(&:fitness)
    end

    attr_reader :offset, :scale, :individuals_by_fitness

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
  end
end
