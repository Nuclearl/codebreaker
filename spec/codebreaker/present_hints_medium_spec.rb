module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    before do
      game.start
    end

    context '#present_hints' do
      context '#medium' do
        it 'should return true if hint was not use and difficulty is medium' do
          game.assign_difficulty(:medium)
          expect(game.present_hints).to be_truthy
        end

        it 'should return false if hint was use one time and difficulty is medium' do
          game.assign_difficulty(:medium)
          game.set_hint
          expect(game.present_hints).to be_falsey
        end
      end
    end
  end
end
