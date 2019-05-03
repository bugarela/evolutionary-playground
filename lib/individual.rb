class Individual
  def initialize(problem, chromossomes, generation=0)
    @problem = problem
    @chromossomes = chromossomes
    @generation = generation
    @info = {}
  end

  attr_reader :info, :chromossomes

  def fitness
    # raise if @fitness and ((@problem.offset + @problem.evaluate(self).to_f) / @problem.scale) != @fitness
    @fitness ||= (@problem.offset + @problem.evaluate(self).to_f) / @problem.scale
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