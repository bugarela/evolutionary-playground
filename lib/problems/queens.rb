require_relative 'base'
require_relative '../population'

class Queens < Base
  def initialize(population_size, n)
    @n = n
    super(population_size)
    @population = generate_population

  end

  attr_reader :population

  def generate_population
    individuals = Population::IntegerPermutation.new(@population_size, @n, lower: 0, upper: @n-1).individuals
    individuals.map { |chromossomes| Queens::Individual.new(self, chromossomes) }
  end

  def evaluate(individual)
    diagonals = []
    individual.each_with_index do |position, index|
      diagonals << position - index
    end
    return @n - diagonals.uniq.length
  end

  class Queens::Individual
    def initialize(problem, chromossomes)
      @problem = problem
      @chromossomes = chromossomes
      @info = {}
    end

    attr_reader :info, :chromossomes

    def fitness
      @fitness ||= (8 - @problem.evaluate(@chromossomes)).to_f / 8
    end
  end
end
