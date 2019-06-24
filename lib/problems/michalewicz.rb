require 'facets'
require_relative 'base'
require_relative '../populations/binary'

module Problems
  class Michalewicz < Base
    VARIABLE_SIZE = 12 #37
    DECIMAL_FACTOR = 1_000 #10_000_000_000

    def initialize(population_args)
      @population_args = population_args
      @n = @population_args[:dimensionality]
      @population_args[:dimensionality] *= VARIABLE_SIZE
      super(
        offset: 0,
        scale: 50,
        scale_fitness: false,
      )
    end

    attr_reader :population

    def new_population
      Populations::Binary.new(self, @population_args).individuals
    end

    def evaluate(individual)
      translated = individual.value
      function(translated)
    end

    def translate(chromossomes)
      decoded = decode(chromossomes)
      adjust_scale(decoded)
    end

    def show_variables(best_value)
      puts "#{best_value.inspect}".yellow
    end

    def show_evaluation(individual)
      puts individual.simple_fitness
      puts individual.fitness

      puts "Evaluation: #{evaluate(individual)}".yellow
    end

    private

    def function(variables)
      variables.map_with_index do |x, i|
        Math::sin(x) * Math::sin(i*x**2/Math::PI)**20
      end.inject(:+)

    end

    def decode(binary)
      variables = []
      binary.each_slice(VARIABLE_SIZE) do |variable|
        integer = variable.first(2).inject { |a,b| a.to_s + b.to_s }.to_i(2)
        decimal = variable.last(VARIABLE_SIZE - 2).inject { |a,b| a.to_s + b.to_s }.to_i(2)
        variables << integer + (decimal % DECIMAL_FACTOR).to_f / DECIMAL_FACTOR
      end
      variables
    end

    def adjust_scale(variables)
      variables.map do |variable|
        if variable >= Math::PI
          Math::PI - 0.0000000001
        elsif variable == 0
          0.0000000001
        else
          variable
        end
      end
    end
  end
end
