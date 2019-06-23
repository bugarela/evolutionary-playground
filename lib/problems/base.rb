require 'pry'
require 'colorize'
require 'parallel'
require_relative '../individual'

module Problems
  class Base
    def initialize(offset:, scale:, log_scale: nil)
      @offset = offset
      @scale = scale
      @log_scale = log_scale
    end

    C = 1.5

    attr_reader :offset, :scale, :log_scale, :individuals_by_fitness

    def population_size
      individuals_by_fitness.length
    end

    def alpha
      calculate_scaled_fitness_coefficients unless @alpha

      @alpha
    end

    def beta
      calculate_scaled_fitness_coefficients unless @beta

      @beta
    end

    def calculate_scaled_fitness_coefficients
      f_min = worst.simple_fitness
      f_max = best.simple_fitness
      f_avg = average_fitness

      if f_min > (C * f_avg - f_max) / (C - 1)
        @alpha = (f_avg * (C - 1))/(f_max - f_avg)
        @beta = (f_avg * (f_max - C*f_avg))/(f_max - f_avg)
      else
        @alpha = (f_avg)/(f_avg - f_min)
        @beta = (-f_min * f_avg)/(f_avg - f_min)
      end
    end

    def best
      individuals_by_fitness.last
    end

    def worst
      individuals_by_fitness.first
    end

    def average_fitness
      individuals_by_fitness.map(&:simple_fitness).mean
    end

    def penality(_individual)
      0
    end

    def gap(percentage)
      number = population_size * percentage
      individuals_by_fitness.sample(number)
    end

    def update_individuals!(new_individuals, generation, keep: nil)
      individuals = new_individuals.map do |individual|
        Individual.new(self, individual, generation)
      end
      @individuals_by_fitness = calculate(individuals).sort_by(&:simple_fitness)

      if keep && !keep.empty?
        individuals = @individuals_by_fitness.drop(keep.length)
        keep.each do |individual_to_keep|
          individual_to_keep.reset_fitness!
          individuals << individual_to_keep
        end
        @individuals_by_fitness = calculate(individuals).sort_by(&:simple_fitness)
      end

      @individuals_by_fitness
    end

    def reset_individuals!
      @alpha = nil
      @beta = nil
      @individuals_by_fitness = calculate(new_population).sort_by(&:simple_fitness)
    end

    def individuals_by_fitness
      @individuals_by_fitness ||= calculate(new_population).sort_by(&:simple_fitness)
    end

    def calculate(population)
      Parallel.map(population, in_threads: 6) do |individual|
        individual.simple_fitness
        individual
      end
    end
  end
end
