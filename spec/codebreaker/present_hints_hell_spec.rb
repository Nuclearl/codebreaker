module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    before do
      game.start
    end

    context '#present_hints' do
      context '#hell' do
        it 'should return true if hint was not use and difficulty is hell' do
          game.assign_difficulty(:hell)
          expect(game.present_hints).to be_truthy
        end

        it 'should return false if hint was use one time and difficulty is hell' do
          game.assign_difficulty(:hell)
          game.set_hint
          expect(game.present_hints).to be_falsey
        end
      end
    end
  end
end
