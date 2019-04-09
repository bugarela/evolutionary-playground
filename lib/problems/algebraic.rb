require_relative 'problem'
require_relative '../population'

class Algebraic < Problem
  def initialize(population_size, dimensionality)
    super(population_size)
    @dimensionality = dimensionality
    @population = generate_population
  end

  attr_reader :population

  def generate_population
    Population::Binary.new(@population_size, @dimensionality)
  end

  def evaluate(individual)
    translated = translate(individual)
    function(translated) + 4
  end

  def translate(individual)
    decoded = decode(individual)
    adjust_scale(decoded)
  end

  def best
    raw = @population.individuals.sort_by { |individual| evaluate(individual) }.last
    best = translate(raw)
    return best, function(best)
  end

  def worst
    raw = @population.individuals.sort_by { |individual| evaluate(individual) }.first
    best = translate(raw)
    return best, function(best)
  end

  private

  def function(number)
    Math::cos(20 * number) - number.abs / 2 + number**3 / 4
  end

  def decode(binary)
    integer = binary.first(2).inject { |a,b| a.to_s + b.to_s }.to_i(2)
    decimal = binary.last(14).inject { |a,b| a.to_s + b.to_s }.to_i(2)
    integer + (decimal.to_f % 10_000) / 10_000
  end

  def adjust_scale(number)
    number - 2
  end
end

# puts Algebraic.new(1000, 16).best
