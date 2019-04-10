class Optimizer
  def initialize(problem, selector, mutation, crossover)
    @problem = problem
    @selector = selector
    @mutation = mutation
    @crossover = crossover
  end

  def run(number_of_generations)
    max = 0
    number_of_generations.times do
      selected_population = @selector.select(@problem)

      mutated_individuals = @mutation.mutate(selected_population)

      recombined_individuals = @crossover.recombine(mutated_individuals)

      @problem.update_population!(recombined_individuals)
      @problem.show_generation
      max = @problem.best_value if @problem.best_value > max
    end
    puts max
  end
end

require_relative 'problems/radio_factory'
require_relative 'selectors/roulette'
require_relative 'mutations/bit_flip'
require_relative 'crossovers/two_point'

population_args = {
  size: 20,
  dimensionality: 4,
}

Optimizer.new(
  RadioFactory.new(population_args),
  Selectors::Roulette.new(reposition: true),
  Mutations::BitFlip.new(0.05),
  Crossovers::TwoPoint.new(0.8)
).run(100)