require 'facets'
require_relative 'base'
require_relative '../populations/binary'

module Problems
  class KeanesBump < Base
    VARIABLE_SIZE = 37 #12 #37
    DECIMAL_FACTOR = 10_000_000_000 # 1_000

    def initialize(population_args)
      @population_args = population_args
      @n = @population_args[:dimensionality]
      @population_args[:dimensionality] *= VARIABLE_SIZE
      super(
        offset: 0,
        scale: 1,
      )
    end

    attr_reader :population

    def new_population
      Populations::Binary.new(self, @population_args).individuals
    end

    def evaluate(individual)
      translated = individual.value
      return 0 if restriction(translated)
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
      (variables.map { |x| Math.cos(x)**4 }.inject(:+) -
        2 * variables.map { |x| Math.cos(x)**2 }.inject(:*)
      ).abs / Math.sqrt(
        variables.map_with_index { |x, i| (i+1)*x**2 }.inject(:+)
      )
    end

    def restriction(variables)
      variables.inject(:*) <= 0.75 ||
        variables.inject(:+) >= 15 * @n / 2
    end

    def decode(binary)
      variables = []
      binary.each_slice(VARIABLE_SIZE) do |variable|
        integer = variable.first(4).inject { |a,b| a.to_s + b.to_s }.to_i(2)
        decimal = variable.last(VARIABLE_SIZE - 4).inject { |a,b| a.to_s + b.to_s }.to_i(2)
        variables << integer + (decimal % DECIMAL_FACTOR).to_f / DECIMAL_FACTOR
      end
      variables.sort.reverse
    end

    def adjust_scale(variables)
      variables.map do |variable|
        if variable >= 10
          9.9999999999
        elsif variable == 0
          0.0000000001
        else
          variable
        end
      end
    end
  end
end
