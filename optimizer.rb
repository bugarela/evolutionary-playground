class Optimizer
  def initialize(problem, selector)
    @problem = problem
    @selector = selector.new(problem)
  end

  def run(number_of_generations)
    number_of_generations.times do
      population = @selector.select
      puts population.map(&:chromossomes).join(' ')
    end
  end
end

require_relative 'problems/radio_factory'
require_relative 'selector'

puts Optimizer.new(RadioFactory.new(10), Selector::Roulette).run(10)