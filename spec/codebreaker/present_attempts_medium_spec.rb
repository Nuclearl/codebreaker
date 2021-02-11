module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    before do
      game.start
    end
    context '#present_attempts' do
      context '#medium' do
        it 'should return true if attempt was not use and difficulty is medium' do
          game.assign_difficulty(:medium)
          expect(game.present_attempts).to be_truthy
        end

        it 'should return true if attempt was use one time and difficulty is medium' do
          game.assign_difficulty(:medium)
          game.matrix_generator('1111')
          expect(game.present_attempts).to be_truthy
        end

        it 'should return false if attempt was use ten times and difficulty is medium' do
          game.assign_difficulty(:medium)
          10.times { game.matrix_generator('1111') }
          expect(game.present_attempts).to be_falsey
        end
      end
    end
  end
end
