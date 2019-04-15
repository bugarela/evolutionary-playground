require 'pry'
require 'colorize'

module Problems
  class Base
    def initialize(population, offset:, scale:)
      @population = population
      @offset = offset
      @scale = scale
    end

    attr_reader :population, :offset, :scale

    def population_size
      population.individuals.length
    end

    def best
      population_by_fitness.last
    end

    def worst
      population_by_fitness.first
    end

    def average_fitness
      population.individuals.map(&:fitness).mean
    end

    def population_by_fitness
      @population_by_fitness ||= @population.individuals.sort_by(&:fitness)
    end

    def update_population!(new_population, keep: nil)
      @population.individuals = new_population.map do |individual|
        Individual.new(self, individual)
      end
      @population_by_fitness = nil

      if keep
        @population.individuals = population_by_fitness.drop(1)
        @population.individuals << keep
        @population_by_fitness = nil
      end
    end
  end
end
