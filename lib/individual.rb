class Individual
  def initialize(problem, chromossomes, generation=0)
    @problem = problem
    @chromossomes = chromossomes
    @generation = generation
    @info = {}
  end

  attr_reader :info, :chromossomes

  def fitness
    @fitness ||= (@problem.offset + penalized_evalutation.to_f) / @problem.scale
  end

  def penalized_evalutation
    @problem.evaluate(self) - @problem.penality(self)
  end

  def reset_fitness!
    @fitness = nil
  end

  def value
    @value ||= @problem.translate(@chromossomes)
  end

  def show
    puts "Generation: #{@generation}".blue
    puts "Chromossomes: #{@chromossomes.inspect}".blue
    puts "Fitness: #{fitness}".blue

    @problem.show_variables(value)
    @problem.show_evaluation(self)
  end
end