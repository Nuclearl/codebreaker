module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    before do
      game.start
    end

    context '#present_hints' do
      context '#easy' do
        it 'should return true if hint was not use and difficulty is easy' do
          game.assign_difficulty(:easy)
          expect(game.present_hints).to be_truthy
        end

        it 'should return true if hint was use one time and difficulty is easy' do
          game.assign_difficulty(:easy)
          game.set_hint
          expect(game.present_hints).to be_truthy
        end

        it 'should return false if hint was use twice time and difficulty is easy' do
          game.assign_difficulty(:easy)
          game.set_hint
          game.set_hint
          expect(game.present_hints).to be_falsey
        end
      end
    end
  end
end
