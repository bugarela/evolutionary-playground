require_relative 'base'

module Crossovers
  class OnePoint < Base
    def initialize(crossover_probability)
      super
    end

    def crossover(parents)
      first = parents[0]
      second = parents[1]
      offspring = []

      point = rand(0..first.length)
      offspring[0] = (first.take(point).concat second.drop(point))
      offspring[1] = (second.take(point).concat first.drop(point))

      offspring
    end
  end
end