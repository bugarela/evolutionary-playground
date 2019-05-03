class Individual
  def initialize(problem, chromossomes)
    @problem = problem
    @chromossomes = chromossomes
    @info = {}
  end

  attr_reader :info, :chromossomes
  # attr_writer :chromossomes

  def fitness
    # binding.pry if ((@problem.offset + @problem.evaluate(self).to_f) / @problem.scale) == 1 and @problem.evaluate(self) != 0
    @fitness ||= (@problem.offset + @problem.evaluate(self).to_f) / @problem.scale
  end

  def value
    @value ||= @problem.translate(@chromossomes)
  end

  def show
    # binding.pry
    puts "Chromossomes: #{@chromossomes.inspect}".blue
    puts "Fitness: #{fitness}".blue

    @problem.show_variables(value)
    @problem.show_evaluation(self)
  end
end