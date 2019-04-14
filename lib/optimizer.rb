require_relative 'plotter'

class Optimizer
  def initialize(problem, selector, mutation, crossover, elitism: false)
    @problem = problem
    @selector = selector
    @mutation = mutation
    @crossover = crossover
  end

  attr_reader :elitism

  def run(number_of_generations)
    current_best_fitness = 0
    best_individual = nil
    generations_best = []
    generations_average = []
    generations_worst = []

    number_of_generations.times do
      selected_population = @selector.select(@problem, @elitism)

      selected_population.concat @problem.best.chromossomes if @elitism

      mutated_individuals = @mutation.mutate(selected_population)

      recombined_individuals = @crossover.recombine(mutated_individuals)

      @problem.update_population!(recombined_individuals)

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
    Plotter.new.plot(generations_best, generations_average, generations_worst)
  end
end

require_relative 'problems/radio_factory'
require_relative 'selectors/tournament'
require_relative 'mutations/bit_flip'
require_relative 'crossovers/two_point'

population_args = {
  size: 20,
  dimensionality: 4,
}

Optimizer.new(
  Problems::RadioFactory.new(population_args),
  Selectors::Tournament.new(k: 2, kp: 1),
  Mutations::BitFlip.new(0.05),
  Crossovers::TwoPoint.new(0.99),
  # elitism: true
).run(100)