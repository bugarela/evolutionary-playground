class Individual
  def initialize(problem, chromossomes)
    @problem = problem
    @chromossomes = chromossomes
    @info = {}
  end

  attr_reader :info, :chromossomes
  attr_writer :chromossomes

  def fitness
    @fitness ||= @problem.evaluate(self).to_f / 1040
  end

  def value
    @value ||= @problem.translate(@chromossomes)
  end
end