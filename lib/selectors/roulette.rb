module Selectors
  class Roulette
    def initialize(reposition: true)
      @reposition = reposition
    end

    def select(problem)
      @problem = problem

      set_probablities

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

    def set_probablities
      sum = 0
      @problem.population_by_fitness.each do |individual|
        individual.info[:probablity] = sum + relative_fitness(individual)
        sum += relative_fitness(individual)
      end
    end

    def relative_fitness(individual)
      individual.fitness.to_f / cumulative_fitness
    end

    def cumulative_fitness
      sum = 0
      @problem.population.each { |individual| sum += individual.fitness }
      sum
    end
  end
end

# require_relative 'problems/queens'
# puts Selector::Roulette.new(Queens.new(10, 8)).select(reposition: false).map(&:chromossomes)
