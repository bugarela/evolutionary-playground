require_relative 'base'

module Selectors
  class Roulette < Base
    def initialize(reposition: false, uniform_ranking: false)
      @reposition = reposition
      @uniform_ranking = uniform_ranking
    end

    def selection
      @uniform_ranking ? set_uniform_probabilities : set_probabilities

      roulette = rand(0.0..1.0)
      population_by_fitness = @problem.population_by_fitness
      new_population = []

      @problem.population_size.times do
        roulette_slice = population_by_fitness.each_cons(2).select do |elements|
          elements.first.info[:probablity] <= roulette and roulette < elements.last.info[:probablity]
        end

        if roulette_slice.empty?
          selected = population_by_fitness.last
        else
          selected = roulette_slice.first.first
        end

        population_by_fitness.reject { |individual| individual == selected } unless @reposition
        new_population << selected
      end

      new_population
    end

    private

    def set_probabilities
      sum = 0
      @problem.population_by_fitness.each do |individual|
        individual.info[:probablity] = sum + relative_fitness(individual)
        sum += relative_fitness(individual)
      end
    end

    def set_uniform_probabilities
      sum = (@problem.population_size + 1) * @problem.population_size / 2

      @problem.population_by_fitness.each_with_index do |individual, index|
        individual.info[:probablity] = (index + 1) / sum.to_f
      end
    end

    def relative_fitness(individual)
      individual.fitness.to_f / cumulative_fitness
    end

    def cumulative_fitness
      sum = 0
      @problem.population_by_fitness.each { |individual| sum += individual.fitness }
      sum
    end
  end
end

# require_relative 'problems/queens'
# puts Selector::Roulette.new(Queens.new(10, 8)).select(reposition: false).map(&:chromossomes)
