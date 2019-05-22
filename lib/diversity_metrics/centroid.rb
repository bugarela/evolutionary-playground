module DiversityMetrics
  class Centroid
    def initialize(population)
      @population = population
    end

    def measure
      diversity = []

      @population.each do |individual|
        distance = 0
        individual.chromossomes.each do |chromossome|
          distance += (chromossome - centroid)**2
        end
        diversity << Math.sqrt(distance)
      end

      diversity
    end

    def centroid
      @centroid ||= @population.map(&:chromossomes).transpose.map(&:mean).mean
    end
  end
end
