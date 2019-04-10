class Problem
  def initialize(population)
    @population = population
  end

  attr_reader :population

  def population_size
    population.length
  end

  def best
    population_by_fitness.first
  end

  def worst
    population_by_fitness.last
  end

  def best_value
    evaluate(best)
  end

  def population_by_fitness
    @population.sort_by(&:fitness)
  end
end
