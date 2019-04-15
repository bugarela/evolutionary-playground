module Mutations
  class Swap
    def initialize(mutation_probability)
      @mutation_probability = mutation_probability
    end

    def mutate(individuals)
      individuals.map do |individual|
        if rand(0.0..1.0) < @mutation_probability
          position_one = rand(0..individual.chromossomes.length - 1)
          position_two = rand(0..individual.chromossomes.length - 1)
          mutated = individual.chromossomes
          mutated[position_one], mutated[position_two] = mutated[position_two], mutated[position_one]
          mutated
        else
          individual.chromossomes
        end
      end
    end
  end
end