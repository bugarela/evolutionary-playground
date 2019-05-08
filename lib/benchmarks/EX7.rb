require_relative '../optimizer'
require_relative '../problems/weighted_queens'
require_relative '../selectors/tournament'
require_relative '../mutations/swap'
require_relative '../crossovers/pmx'

population_args = {
  size: 50,
}

Optimizer.new(
  Problems::WeightedQueens.new(population_args, 128),
  Selectors::Tournament.new(k: 2, kp: 1),
  Mutations::Swap.new(0.15),
  Crossovers::PMX.new(0.99),
  elitism: true
).test(runs: 30, generations: 2000)