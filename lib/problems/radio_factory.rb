require 'colorize'

require_relative 'base'
require_relative '../individual'
require_relative '../populations/binary'

module Problems
  class RadioFactory < Base
    def initialize(population_args)
      super(Population::Binary.new(self, population_args))
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

    def show_variables(best_value)
      lux_employees = best_value
      standard_employees = 40 - best_value

      puts "Employees: #{standard_employees} Standart, #{lux_employees} Lux".yellow
    end

    private

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
end
