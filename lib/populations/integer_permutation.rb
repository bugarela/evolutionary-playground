require_relative 'base'

module Populations
  class IntegerPermutation < Base
    def initialize(problem, bounds:, size:, dimensionality:)
      @bounds = bounds
      super(problem, size, dimensionality)
    end

    attr_writer :individuals

    def individuals
      @individuals ||= Array.new(@size) do
        chromossomes = (Array @bounds[:lower]..@bounds[:upper]).shuffle
        chromossomes = chromossomes.take(@dimensionality)
        Individual.new(@problem, chromossomes)
      end
    end
  end
end
