module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    before do
      game.start
    end

    context '#set_hint' do
      it 'secret code include hint' do
        expect(game.instance_variable_get(:@secret_code)).to include game.use_hint
      end

      it 'should return empty if used hint' do
        game.instance_variable_set(:@available_hints, '1')
        game.use_hint

        expect(game.use_hint).to eq ' '
      end
    end
  end
end
