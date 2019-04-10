require_relative '../lib/populations/binary.rb'
require_relative '../lib/populations/integer.rb'
require_relative '../lib/populations/integer_permutation.rb'
require_relative '../lib/populations/real.rb'


RSpec.describe Population do
  let(:population_size) { 10 }
  let(:dimensionality) { 20 }
  let(:mutation_probability) { 0.1 }
  let(:crossover_probability) { 0.1 }
  let(:bounds) do
    {
      lower: -1,
      upper: 23.1,
    }
  end

  shared_examples_for 'a successful generation' do
    it 'has the right number of individuals' do
      expect(population.individuals.length).to eq(population_size)
    end

    it 'has right sized chromossomes' do
      population.individuals.each do |chromossome|
        expect(chromossome.length).to eq(dimensionality)
      end
    end
  end

  describe 'a binary population' do
    let(:population) { Population::Binary.new(population_size, dimensionality, mutation_probability, crossover_probability) }

    it_behaves_like 'a successful generation'

    it 'has only binary genes' do
      population.individuals.each do |chromossome|
        chromossome.each do |gene|
          expect(gene).to eq(0).or eq(1)
        end
      end
    end
  end

  describe 'a integer population' do
    let(:population) { Population::Integer.new(population_size, dimensionality, mutation_probability, crossover_probability, bounds) }

    it_behaves_like 'a successful generation'

    it 'has only integer genes' do
      population.individuals.each do |chromossome|
        chromossome.each do |gene|
          expect(gene).to be_a(Integer)
        end
      end
    end

    it 'respects the bounds' do
      population.individuals.each do |chromossome|
        chromossome.each do |gene|
          expect(gene).to be_between(bounds[:lower], bounds[:upper])
        end
      end
    end
  end

  describe 'a integer permutation population' do
    let(:population) { Population::IntegerPermutation.new(population_size, dimensionality, mutation_probability, crossover_probability, bounds) }

    it_behaves_like 'a successful generation'

    it 'has only integer genes' do
      population.individuals.each do |chromossome|
        chromossome.each do |gene|
          expect(gene).to be_a(Integer)
        end
      end
    end

    it 'respects the bounds' do
      population.individuals.each do |chromossome|
        chromossome.each do |gene|
          expect(gene).to be_between(bounds[:lower], bounds[:upper])
        end
      end
    end

    it 'has permutated values on all chromossomes' do
      population.individuals.each do |chromossome|
        expect(chromossome.uniq.length).to eq(dimensionality)
      end
    end
  end

  describe 'a real population' do
    let(:population) { Population::Real.new(population_size, dimensionality, mutation_probability, crossover_probability, bounds) }

    it_behaves_like 'a successful generation'

    it 'has only real genes' do
      population.individuals.each do |chromossome|
        chromossome.each do |gene|
          expect(gene).to be_a(Float)
        end
      end
    end

    it 'respects the bounds' do
      population.individuals.each do |chromossome|
        chromossome.each do |gene|
          expect(gene).to be_between(bounds[:lower], bounds[:upper])
        end
      end
    end
  end
end