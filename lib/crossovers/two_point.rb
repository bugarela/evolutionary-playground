require_relative 'base'

module Crossovers
  class TwoPoint < Base
    def initialize(crossover_probability)
      super
    end

    def crossover(parents)
      first = parents[0]
      second = parents[1]
      offspring = []

      points = [rand(0..first.length - 1), rand(0..first.length - 1)].sort
      point_one = points[0]
      point_two = points[1]

      offspring[0] = (first.take(point_one).concat second.take(point_two).drop(point_one).concat first.drop(point_two))
      offspring[1] = (second.take(point_one).concat first.take(point_two).drop(point_one).concat second.drop(point_two))

      offspring
    end
  end
end