require_relative '../optimizer'
require_relative '../problems/keanes_bump'
require_relative '../selectors/tournament'
require_relative '../mutations/bit_flip'
require_relative '../crossovers/one_point'

population_args = {
  size: 45,
  dimensionality: 50
}

Optimizer.new(
  Problems::KeanesBump.new(population_args),
  Selectors::Tournament.new(k: 2, kp: 1),
  Mutations::BitFlip.new(0.01),
  Crossovers::OnePoint.new(0.95),
  elitism: true,
  generation_gap: 0.85
).test(runs: 10, generations: 7000)

# Average: 0.8245594018420815
# Standard Deviation: 0.002533675410617354
