module Mutations
  class BitFlip
    def initialize(mutation_probability)
      @mutation_probability = mutation_probability
    end

    def mutate!(individuals)
      individuals.each do |individual|
        individual.chromossomes = individual.chromossomes.map do |chromossome|
          if rand(0.0..1.0) < @mutation_probability
            1 - chromossome
          else
            chromossome
          end
        end
      end
    end
  end
end