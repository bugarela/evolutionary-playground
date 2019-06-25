require_relative '../optimizer'
require_relative '../problems/michalewicz'
require_relative '../selectors/tournament'
require_relative '../mutations/bit_flip'
require_relative '../crossovers/one_point'

population_args = {
  size: 35,
  dimensionality: 50
}

Optimizer.new(
  Problems::Michalewicz.new(population_args),
  Selectors::Tournament.new(k: 2, kp: 1),
  Mutations::BitFlip.new(0.005),
  Crossovers::OnePoint.new(0.8),
  elitism: true,
  generation_gap: 0.7
).test(runs: 10, generations: 8000)

# Average: 0.8830744802383673
# Standard Deviation: 0.019368352509897647
