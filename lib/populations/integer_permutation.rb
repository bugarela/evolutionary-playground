require_relative 'base'

module Population
  class IntegerPermutation < Base
    def initialize(size, dimensionality, mutation_probability, crossover_probability, bounds)
      @bounds = bounds
      super(size, dimensionality, mutation_probability, crossover_probability)
    end

    def individuals
      @size.times.collect do
        integers = (Array @bounds[:lower]..@bounds[:upper]).shuffle
        integers.take(@dimensionality)
      end
    end
  end
end
