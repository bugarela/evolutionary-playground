require_relative '../optimizer'
require_relative '../problems/keanes_bump'
require_relative '../selectors/tournament'
require_relative '../mutations/bit_flip'
require_relative '../crossovers/one_point'

population_args = {
  size: 15,
  dimensionality: 50
}

Optimizer.new(
  Problems::KeanesBump.new(population_args),
  Selectors::Tournament.new(k: 2, kp: 1),
  Mutations::BitFlip.new(0.02),
  Crossovers::OnePoint.new(0.9),
  elitism: true,
  generation_gap: 0.8
).test(runs: 2, generations: 20000)
