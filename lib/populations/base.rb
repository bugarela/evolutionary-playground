module Population
  class Base
    def initialize(problem, size, dimensionality)
      @problem = problem
      @size = size
      @dimensionality = dimensionality
    end

    def show
      individuals.each do |chromossomes|
        puts chromossomes.join ' '
      end
    end
  end
end
