require_relative '../../problems/queens.rb'

RSpec.describe Queens do
  let(:problem) { described_class.new(10, 8) }
  describe '.fitness' do
    context 'when the board is valid' do
      let(:board) { Queens::Individual.new(problem, [0, 6, 3, 5, 7, 1, 4, 2]) }

      it 'returns 0' do
        expect(board.fitness).to eq(1)
      end
    end

    context 'when the board is invalid' do
      let(:board) { Queens::Individual.new(problem, [0, 6, 2, 5, 7, 1, 4, 3]) }

      it 'returns the number of conflicts' do
        expect(board.fitness).to eq(0.75)
      end
    end
  end
end