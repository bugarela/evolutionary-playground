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
      population.individuals.map(&:fitness).reduce(:+).to_f / population_size
    end

    def population_by_fitness
      @population_by_fitness ||= @population.individuals.sort_by(&:fitness)
    end

    def update_population!(new_population)
      @population_by_fitness = nil
      @population.individuals = new_population.map do |individual|
        Individual.new(self, individual)
      end
    end
  end
end
