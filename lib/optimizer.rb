require 'descriptive_statistics'
require_relative 'plotter'

class Optimizer
  def initialize(problem, selector, mutation, crossover,
    elitism: false, generation_gap: 0, diversity_metric: nil)
    @problem = problem
    @selector = selector
    @mutation = mutation
    @crossover = crossover
    @elitism = elitism
    @generation_gap = generation_gap
    @diversity_metric = diversity_metric
  end

  def test(runs:, generations:)
    best_average = []
    average_average = []
    worst_average = []
    final_bests = []

    Parallel.each(runs.times, in_threads: 1, progress: "Doing stuff") do |_|
      best, average, worst, diversity = run(generations)
      best_average << best
      average_average << average
      worst_average << worst
      final_bests << best.max
    end

    best_average = best_average.transpose.map(&:mean)
    average_average = average_average.transpose.map(&:mean)
    worst_average = worst_average.transpose.map(&:mean)

    Plotter.new.plot(best_average, average_average, worst_average)
    puts "Average: #{final_bests.mean}".red
    puts "Standard Deviation: #{final_bests.standard_deviation}".red
  end

  def run(number_of_generations)
    @problem.reset_individuals!

    best_individual = nil
    generations_best = []
    generations_average = []
    generations_worst = []
    generations_diversity = []

    number_of_generations.times do |generation|
      diversity = @diversity_metric.new(@problem.individuals_by_fitness).measure if @diversity_metric

      selected_population = @selector.select(@problem)

      mutated_individuals = @mutation.mutate(selected_population)

      recombined_individuals = @crossover.recombine(mutated_individuals)

      if @elitism
        @problem.update_individuals!(
          recombined_individuals,
          generation,
          keep: ([best_individual] + @problem.gap(@generation_gap)).compact
        )
      else
        @problem.update_individuals!(
          recombined_individuals,
          generation,
          keep: @problem.gap(@generation_gap)
        )
      end

      best_individual ||= @problem.best.dup

      if @problem.best.fitness > best_individual.fitness
        best_individual = @problem.best.dup
      end

      generations_best << @problem.best.fitness
      generations_average << @problem.average_fitness
      generations_worst << @problem.worst.fitness
      generations_diversity << diversity if @diversity_metric
    end

    puts 'Best Individual'.green
    best_individual.show

    [generations_best, generations_average, generations_worst, generations_diversity]
  end
end
