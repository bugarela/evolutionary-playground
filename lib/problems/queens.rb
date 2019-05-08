require_relative 'base'
require_relative '../individual'
require_relative '../populations/integer_permutation'

module Problems
  class Queens < Base
    def initialize(population_args, n)
      @n = n

      @population_args = population_args.merge(problem_population_args)

      super(
        offset: -1 * n,
        scale: -1 * n,
        # log_scale: 8,
      )
    end

    def evaluate(individual)
      positive_diagonal = []
      negative_diagonal = []

      individual.chromossomes.each_with_index do |position, index|
        positive_diagonal << position - index
        negative_diagonal << position + index
      end

      2*@n - positive_diagonal.uniq.length - negative_diagonal.uniq.length
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
      # puts 'Board:'.yellow
      # best_value.each do |row|
      #   puts (row.join ' ').yellow
      # end
    end

    def show_evaluation(individual)
      puts "Conflicts: #{evaluate(individual)}".yellow
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
  end
end
