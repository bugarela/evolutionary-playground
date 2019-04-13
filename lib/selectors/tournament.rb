require_relative 'base'

module Selectors
  class Tournament < Base
    def initialize(k:, kp:)
      @k = k
      @kp = kp
    end

    def selection
      new_population = []
      rounds = @problem.population_size

      rounds.times do
        competitors = @problem.population.individuals.sample(@k)
        competitors = competitors.sort_by(&:fitness)
        if @kp >= rand(0.0..1.0)
          new_population << competitors.last
        else
          new_population << competitors.first
        end
      end

      new_population
    end
  end
end