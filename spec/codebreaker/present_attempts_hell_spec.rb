module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    before do
      game.start
    end

    context '#present_attempts' do
      context '#hell' do
        it 'should return true if attempt was not use and difficulty is hell' do
          game.assign_difficulty(:hell)
          expect(game.present_attempts).to be_truthy
        end

        it 'should return true if attempt was use one time and difficulty is hell' do
          game.assign_difficulty(:hell)
          game.matrix_generator('1111')
          expect(game.present_attempts).to be_truthy
        end

        it 'should return false if attempt was use five times and difficulty is hell' do
          game.assign_difficulty(:hell)
          5.times { game.matrix_generator('1111') }
          expect(game.present_attempts).to be_falsey
        end
      end
    end
  end
end
