module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    before do
      game.start
    end

    context '#present_attempts' do
      context '#easy' do
        it 'should return true if attempt was not use and difficulty is easy' do
          game.assign_difficulty(:easy)
          expect(game.present_attempts).to be_truthy
        end

        it 'should return true if attempt was use one time and difficulty is easy' do
          game.assign_difficulty(:easy)
          game.matrix_generator('1111')
          expect(game.present_attempts).to be_truthy
        end

        it 'should return false if attempt was use fifteen times and difficulty is easy' do
          game.assign_difficulty(:easy)
          15.times { game.matrix_generator('1111') }
          expect(game.present_attempts).to be_falsey
        end
      end
    end
  end
end
