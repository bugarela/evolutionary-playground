require_relative 'base'

module Population
  class Real < Base
    def initialize(size, dimensionality, mutation_probability, crossover_probability, bounds)
      @bounds = bounds.each { |key, bound| bounds[key] = bound.to_f }
      super(size, dimensionality, mutation_probability, crossover_probability)
    end

    def individuals
      Array.new(@size) { Array.new(@dimensionality) { rand(@bounds[:lower]..@bounds[:upper]) } }
    end
  end
end