require 'pry'

module Selectors
  class Base
    def select(problem, elitism)
      @problem = problem
      new_population = selection

      if elitism
        new_population = new_population.sort_by(&:fitness).drop(1)
        new_population << problem.population.best
      end

      new_population
    end
  end
end