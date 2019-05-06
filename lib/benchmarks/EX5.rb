require_relative '../optimizer'
require_relative '../problems/radio_factory'
require_relative '../selectors/tournament'
require_relative '../mutations/bit_flip'
require_relative '../crossovers/one_point'

population_args = {
  size: 20,
}

Optimizer.new(
  Problems::RadioFactory.new(population_args),
  Selectors::Tournament.new(k: 2, kp: 1),
  Mutations::BitFlip.new(0.1),
  Crossovers::OnePoint.new(0.99),
  elitism: true
).test(runs: 30, generations: 20)