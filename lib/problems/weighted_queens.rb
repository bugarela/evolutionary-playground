require_relative 'base'
require_relative '../individual'
require_relative '../populations/integer_permutation'

module Problems
  class WeightedQueens < Base
    def initialize(population_args, n)
      @n = n

      @population_args = population_args.merge(problem_population_args)

      super(
        offset: -23,
        scale: calculate_scale,
      )
    end

    def evaluate(individual)
      positive_diagonal = []
      negative_diagonal = []
      profit = 0

      individual.chromossomes.each_with_index do |position, index|
        positive_diagonal << position - index
        negative_diagonal << position + index
        profit += weights[index][position]
      end

      conflicts = 2 * @n - positive_diagonal.uniq.length - negative_diagonal.uniq.length
      individual.info[:conflicts] = conflicts
      profit
    end

    def penality(individual)
      individual.info[:conflicts] * calculate_scale/2
    end

    def translate(chromossomes)
      board = Array.new(@n) { Array.new(@n) { 0 } }

      chromossomes.each_with_index do |position, index|
        board[index][position] += 1
      end

      board
    end

    def new_population
      Populations::IntegerPermutation.new(self, @population_args).individuals
    end

    def show_variables(best_value)
      puts 'Board:'.yellow
      best_value.each do |row|
        puts (row.join ' ').yellow
      end
    end

    def show_evaluation(individual)
      puts "Profit: #{evaluate(individual)}".green
      puts "Conflicts: #{individual.info[:conflicts]}".red
    end

    private

    def problem_population_args
      {
        dimensionality: @n,
        bounds: {
          lower: 0,
          upper: @n - 1,
        }
      }
    end

    def calculate_scale
      4
      # weights.flatten.sort.reverse.take(@n).sum / 2
    end

    def weights
      return @weights if @weights

      board = Array.new(@n) { Array.new(@n) }
      @n.times do |i|
        @n.times do |j|
          value = 1 + 8 * i + j
          board[i][j] = i.even? ? Math.sqrt(value) : Math.log(value, 10)
        end
      end

      board
    end
  end
end
