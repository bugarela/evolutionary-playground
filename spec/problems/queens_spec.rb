require_relative '../../problems/queens.rb'

RSpec.describe Queens do
  let(:problem) { described_class.new(10, 8) }
  describe '.evaluate' do
    context 'when the board is valid' do
      let(:board) { [0, 6, 3, 5, 7, 1, 4, 2] }

      it 'returns 0' do
        expect(problem.evaluate(board)).to be_zero
      end
    end

    context 'when the board is invalid' do
      let(:board) { [0, 6, 2, 5, 7, 1, 4, 3] }

      it 'returns the number of conflicts' do
        expect(problem.evaluate(board)).to eq(2)
      end
    end
  end
end