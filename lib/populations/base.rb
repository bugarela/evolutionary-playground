module Population
  class Base
    def initialize(size, dimensionality)
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

# Population::Binary.new(10, 10).show
# puts '----'
# Population::Integer.new(10, 10, lower: 0, upper: 3).show
# puts '----'
# Population::IntegerPermutation.new(10, 10, lower: 0, upper: 10).show
# puts '----'
# Population::Real.new(10, 10, lower: 0, upper: 3).show
# puts '----'