require_relative '../optimizer'
require_relative '../problems/labirynt'
require_relative '../selectors/tournament'
require_relative '../mutations/bit_flip'
require_relative '../crossovers/one_point'

population_args = {
  size: 15,
}

Optimizer.new(
  Problems::Labirynt.new(population_args),
  Selectors::Tournament.new(k: 2, kp: 1),
  Mutations::BitFlip.new(0.05),
  Crossovers::OnePoint.new(0.9),
  elitism: true,
  generation_gap: 0.7
).test(runs: 100, generations: 600)

# Average: 0.9881360389693213
# Standard Deviation: 0.02844725696200835
