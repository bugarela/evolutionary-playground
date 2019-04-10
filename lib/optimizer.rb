class Optimizer
  def initialize(problem, selector, mutation, crossover)
    @problem = problem
    @selector = selector.new(problem)
    @mutation = mutation
    @crossover = crossover
  end

  def run(number_of_generations)
    number_of_generations.times do
      @problem.population = @selector.select
      puts @problem.population.map(&:chromossomes).join(' ')

      @mutation.mutate!(@problem.population)
      puts @problem.population.map(&:chromossomes).join(' ')

      @problem.population = @crossover.recombine(@problem.population)
      puts @problem.population.map(&:chromossomes).join(' ')

      puts @problem.best.fitness
    end
  end
end

require_relative 'problems/radio_factory'
require_relative 'selector'
require_relative 'mutations/bit_flip'
require_relative 'crossovers/one_point'

population_args = {
  size: 10,
  dimensionality: 4,
}

Optimizer.new(
  RadioFactory.new(population_args),
  Selector::Roulette,
  Mutations::BitFlip.new(0.9),
  Crossovers::OnePoint.new(0.9)
).run(10)