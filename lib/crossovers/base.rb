module Crossovers
  class Base
    def initialize(crossover_probability)
      @crossover_probability = crossover_probability
    end

    def recombine(population)
      new_population = []
      population.each_slice(2) do |parents|
        if parents.length == 2
          new_population << offspring(parents)
        else
          new_population << parents
        end
      end

      new_population.flatten
    end

    def offspring(parents)
      if rand(0.0..0.1) < @crossover_probability
        crossover(parents)
      else
        parents
      end
    end
  end
end