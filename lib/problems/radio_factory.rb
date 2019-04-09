require_relative 'problem'
require_relative '../population'

class RadioFactory < Problem
  def initialize(population_size)
    super(generate_population(population_size))
  end

  attr_reader :population

  def generate_population(population_size)
    individuals = Population::Binary.new(population_size, 4).individuals
    individuals.map { |chromossomes| RadioFactory::Individual.new(self, chromossomes) }
  end

  def evaluate(individual)
    lux_employees = translate(individual)
    function(lux_employees)
  end

  class RadioFactory::Individual
    def initialize(problem, chromossomes)
      @problem = problem
      @chromossomes = chromossomes
      @info = {}
    end

    attr_reader :info, :chromossomes

    def fitness
      @fitness ||= @problem.evaluate(@chromossomes).to_f / 1040
    end
  end

  private

  def translate(individual)
    decoded = decode(individual)
    adjust_scale(decoded)
  end

  def function(lux_employees)
    standard_employees = 40 - lux_employees

    lux_profit = lux_employees / 2 * 40
    standard_profit = standard_employees / 1 * 30

    lux_profit + standard_profit
  end

  def decode(binary)
    binary.inject { |a, b| a.to_s + b.to_s }.to_i(2)
  end

  def adjust_scale(number)
    2 * (8 + (number * 8 / 15).to_i)
  end
end

puts RadioFactory.new(10)