class Population
  attr_reader :individuals

  def initialize(size, dimensionality)
    @size = size
    @dimensionality = dimensionality
  end

  def show
    individuals.each do |dimensionality|
      puts dimensionality.join ' '
    end
  end

  class Binary < Population
    def initialize(size, dimensionality)
      super
    end

    def individuals
      @size.times.collect { @dimensionality.times.collect { rand(0..1) } }
    end
  end

  class Integer < Population
    def initialize(size, dimensionality, bounds)
      @bounds = bounds.each { |key, bound| bounds[key] = bound.to_i }
      super(size, dimensionality)
    end

    def individuals
      @size.times.collect { @dimensionality.times.collect { rand(@bounds[:lower]..@bounds[:upper]) } }
    end
  end

  class IntegerPermutation < Population
    def initialize(size, dimensionality, bounds)
      @bounds = bounds
      super(size, dimensionality)
    end

    def individuals
      @size.times.collect do
        integers = (Array @bounds[:lower]..@bounds[:upper]).shuffle
        integers.take(@dimensionality)
      end
    end
  end

  class Real < Population
    def initialize(size, dimensionality, bounds)
      @bounds = bounds.each { |key, bound| bounds[key] = bound.to_f }
      super(size, dimensionality)
    end

    def individuals
      @size.times.collect { @dimensionality.times.collect { rand(@bounds[:lower]..@bounds[:upper]) } }
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