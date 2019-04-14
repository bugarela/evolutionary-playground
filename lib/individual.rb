class Individual
  def initialize(problem, chromossomes)
    @problem = problem
    @chromossomes = chromossomes
    @info = {}
  end

  attr_reader :info, :chromossomes
  attr_writer :chromossomes

  def fitness
    @fitness ||= (@problem.offset + @problem.evaluate(self).to_f) / @problem.scale
  end

  def value
    @value ||= @problem.translate(@chromossomes)
  end

  def show
    puts 'Best Individual'.green
    puts "Chromossomes: #{@chromossomes.inspect}".blue
    puts "Fitness: #{fitness}".blue

    @problem.show_variables(value)
    @problem.show_evaluation(self)
  end
end