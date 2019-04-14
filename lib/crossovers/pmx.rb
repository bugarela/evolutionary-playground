require_relative 'base'

module Crossovers
  class PMX < Base
    def initialize(crossover_probability)
      super
    end

    def crossover(parents)
      first = parents[0]
      second = parents[1]
      substitutions = {}

      points = [rand(0..first.length - 1), rand(0..first.length - 1)].sort
      point_one = points[0]
      point_two = points[1]

      [point_one..point_two].each do |index|
        substitutions[first[index]] = second[index]
        substitutions[second[index]] = first[index]
      end

      first = first.map do |element|
        substitutions[element] || element
      end

      second = second.map do |element|
        substitutions[element] || element
      end

      [first, second]
    end
  end
end