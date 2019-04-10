require 'colorize'

require_relative 'problem'
require_relative '../populations/binary'

class RadioFactory < Problem
  def initialize(population_args)
    super(generate_population(population_args))
  end

  attr_reader :population

  def evaluate(individual)
    lux_employees = individual.value
    function(lux_employees)
  end

  def translate(individual)
    decoded = decode(individual)
    adjust_scale(decoded)
  end

  def show_generation
    puts "Best Individual".green
    puts "Chromossomes: #{best.chromossomes.inspect}".blue
    puts "Fitness: #{best.fitness}".blue

    lux_employees = best.value
    standard_employees = 40 - best.value

    puts "Employees: #{standard_employees} Standart, #{lux_employees} Lux".yellow
    puts "Evaluation: $#{best_value}".yellow
    puts '---'
  end

  def update_population!(new_population)
    @population = new_population.map do |individual|
      RadioFactory::Individual.new(self, individual)
    end
  end

  class RadioFactory::Individual
    def initialize(problem, chromossomes)
      @problem = problem
      @chromossomes = chromossomes
      @info = {}
    end

    attr_reader :info, :chromossomes
    attr_writer :chromossomes

    def fitness
      @fitness ||= @problem.evaluate(self).to_f / 1040
    end

    def value
      @value ||= @problem.translate(@chromossomes)
    end
  end

  private

  def generate_population(population_args)
    individuals = Population::Binary.new(population_args).individuals
    individuals.map { |chromossomes| RadioFactory::Individual.new(self, chromossomes) }
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
