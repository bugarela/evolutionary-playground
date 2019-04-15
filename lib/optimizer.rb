require 'descriptive_statistics'
require_relative 'plotter'

class Optimizer
  def initialize(problem, selector, mutation, crossover, elitism: false)
    @problem = problem
    @selector = selector
    @mutation = mutation
    @crossover = crossover
    @elitism = elitism
  end

  def test(runs:, generations:)
    best_average = []
    average_average = []
    worst_average = []
    final_bests = []

    runs.times do
      best, average, worst = run(generations)
      best_average << best
      average_average << average
      worst_average << worst
      final_bests << best.max
    end

    best_average = best_average.transpose.map(&:mean)
    average_average = average_average.transpose.map(&:mean)
    worst_average = worst_average.transpose.map(&:mean)


    Plotter.new.plot(best_average, average_average, worst_average)
    puts "Standard Deviation: #{final_bests.standard_deviation}".red
  end

  def run(number_of_generations)
    current_best_fitness = 0
    best_individual = nil
    generations_best = []
    generations_average = []
    generations_worst = []

    number_of_generations.times do
      selected_population = @selector.select(@problem)

      mutated_individuals = @mutation.mutate(selected_population)

      recombined_individuals = @crossover.recombine(mutated_individuals)

      if @elitism
        @problem.update_population!(recombined_individuals, keep: best_individual)
      else
        @problem.update_population!(recombined_individuals)
      end

      generation_best_fitness = @problem.best.fitness

      if generation_best_fitness > current_best_fitness
        current_best_fitness = generation_best_fitness
        best_individual = @problem.best
      end

      generations_best << @problem.best.fitness
      generations_average << @problem.average_fitness
      generations_worst << @problem.worst.fitness
    end

    best_individual.show

    [generations_best, generations_average, generations_worst]
  end
end

require_relative 'problems/queens'
require_relative 'selectors/tournament'
require_relative 'mutations/swap'
require_relative 'crossovers/pmx'

population_args = {
  size: 20,
}

Optimizer.new(
  Problems::Queens.new(population_args, 64),
  Selectors::Tournament.new(k: 2, kp: 1),
  Mutations::Swap.new(0.1),
  Crossovers::PMX.new(0.99),
  elitism: true
).test(runs: 1, generations: 100)