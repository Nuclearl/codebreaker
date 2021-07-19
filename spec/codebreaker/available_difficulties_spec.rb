module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    before do
      game.start
    end

    context '#available_difficulties' do
      it 'return hash' do
        expect(game.available_difficulties.class).to eq(Hash)
      end

      it 'return constant from class' do
        expect(game.available_difficulties).to eq Game::DIFFICULTIES
      end
    end
  end
end
