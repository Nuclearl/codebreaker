module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    before do
      game.start
    end

    context '#set_hint' do
      it 'secret code include hint' do
        expect(game.secret_code).to include game.set_hint
      end

      it 'should return empty if used 4 hint' do
        game.set_hint
        game.set_hint
        game.set_hint
        game.set_hint

        expect(game.set_hint).to eq ' '
      end
    end
  end
end
