require_relative 'base'

module Population
  class Binary < Base
    def initialize(size:, dimensionality:)
      super(size, dimensionality)
    end

    def individuals
      @individuals ||= Array.new(@size) { Array.new(@dimensionality) { rand(0..1) } }
    end
  end
end
