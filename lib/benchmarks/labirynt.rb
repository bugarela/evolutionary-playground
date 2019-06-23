require_relative '../optimizer'
require_relative '../problems/labirynt'
require_relative '../selectors/tournament'
require_relative '../mutations/bit_flip'
require_relative '../crossovers/one_point'

population_args = {
  size: 150,
}

Optimizer.new(
  Problems::Labirynt.new(population_args),
  Selectors::Tournament.new(k: 2, kp: 1),
  Mutations::BitFlip.new(0.2),
  Crossovers::OnePoint.new(0.9),
  elitism: true,
  generation_gap: 0.7
).test(runs: 2, generations: 250)
