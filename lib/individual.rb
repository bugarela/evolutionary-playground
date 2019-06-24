class Individual
  def initialize(problem, chromossomes, generation=0)
    @problem = problem
    @chromossomes = chromossomes
    @generation = generation
    @info = {}
  end

  attr_reader :info, :chromossomes
  attr_writer :chromossomes

  def simple_fitness
    @simple_fitness ||= [(@problem.offset + penalized_evalutation.to_f) / @problem.scale, 0.1].max
  end

  def fitness
    return simple_fitness unless @problem.scale_fitness?

    @problem.alpha * simple_fitness + @problem.beta
  end

  def log_scaled_evaluation
    Math.log(penalized_evalutation + 1, @problem.log_scale + 1)
  end

  def penalized_evalutation
    @problem.evaluate(self) - @problem.penality(self)
  end

  def reset_fitness!
    @fitness = nil
  end

  def value
    @problem.translate(@chromossomes)
  end

  def show
    puts "Generation: #{@generation}".blue
    puts "Chromossomes: #{@chromossomes.inspect}".blue
    puts "Fitness: #{fitness}".blue

    @problem.show_variables(value)
    @problem.show_evaluation(self)
  end
end
