require_relative '../optimizer'
require_relative '../problems/labirynt'
require_relative '../selectors/tournament'
require_relative '../mutations/bit_flip'
require_relative '../crossovers/two_point'

population_args = {
  size: 30,
}

Optimizer.new(
  Problems::Labirynt.new(population_args),
  Selectors::Tournament.new(k: 2, kp: 1),
  Mutations::BitFlip.new(0.2),
  Crossovers::TwoPoint.new(0.99),
  elitism: true
).test(runs: 3, generations: 100)
