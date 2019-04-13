require_relative 'base'

module Population
  class Binary < Base
    def initialize(problem, size:, dimensionality:)
      super(problem, size, dimensionality)
    end

    attr_writer :individuals

    def individuals
      @individuals ||= Array.new(@size) do
        chromossomes = Array.new(@dimensionality) { rand(0..1) }
        Individual.new(@problem, chromossomes)
      end
    end
  end
end
