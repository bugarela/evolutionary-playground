require 'pry'
require 'colorize'
require_relative '../individual'

module Problems
  class Base
    def initialize(individuals, offset:, scale:)
      @individuals = individuals
      @offset = offset
      @scale = scale
    end

    attr_reader :individuals, :offset, :scale
    attr_writer :individuals

    def population_size
      individuals.length
    end

    def best
      individuals_by_fitness.last
    end

    def worst
      individuals_by_fitness.first
    end

    def average_fitness
      individuals.map(&:fitness).mean
    end

    def individuals_by_fitness
      @individuals_by_fitness ||= @individuals.sort_by(&:fitness)
    end

    def update_individuals!(new_individuals, keep: nil)
      @individuals = new_individuals.map do |individual|
        Individual.new(self, individual)
      end
      @individuals_by_fitness = nil

      if keep
        @individuals = individuals_by_fitness.drop(1)
        @individuals << keep
        @individuals_by_fitness = nil
      end
    end
  end
end
