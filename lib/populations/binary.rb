require_relative 'base'

module Populations
  class Binary < Base
    def initialize(problem, size:, dimensionality:)
      super(problem, size, dimensionality)
      @individuals = generate_individuals
    end

    attr_reader :individuals
    attr_writer :individuals

    def generate_individuals
      Array.new(@size) do
        chromossomes = Array.new(@dimensionality) { rand(0..1) }
        Individual.new(@problem, chromossomes)
      end
    end
  end
end
