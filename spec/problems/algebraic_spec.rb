require_relative '../../problems/algebraic.rb'

RSpec.describe Algebraic do
  let(:problem) { described_class.new(100, 8) }

  describe '.translate' do
    it 'translates inside domain [-2,2]' do
      problem.population.individuals.each do |individual|
        expect(problem.translate(individual)).to be_between(-2,2)
      end
    end
  end

  describe '.evaluate' do
    it 'evaluates inside deslocated image [0,6]' do
      problem.population.individuals.each do |individual|
        expect(problem.evaluate(individual)).to be_between(0,6)
      end
    end
  end
end