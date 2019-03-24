require_relative 'problem'
require_relative '../population'

class Queens < Problem
  def initialize(population_size, n)
    @n = n
    super(population_size)
    @population = generate_population
  end

  attr_reader :population

  def generate_population
    Population::IntegerPermutation.new(@population_size, @n, lower: 0, upper: @n-1)
  end

  def evaluate(individual)
    diagonals = []
    individual.each_with_index do |position, index|
      diagonals << position - index
    end
    return @n - diagonals.uniq.length
  end

  def best
    @population.individuals.sort_by { |individual| evaluate(individual) }.first
  end

  def worst
    @population.individuals.sort_by { |individual| evaluate(individual) }.last
  end
end

# puts Queens.new(10, 8).evaluate([0, 6, 3, 5, 7, 1, 4, 2])
# puts Queens.new(10, 8).evaluate([0, 6, 2, 5, 7, 1, 4, 3])
# puts Queens.new(10,8).worst

