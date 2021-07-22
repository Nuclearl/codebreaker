module Codebreaker
  RSpec.shared_examples 'callable hints' do
    before { stub_const('Codebreaker::Game::DIFFICULTIES', { difficulty => { attempts: 1, hints: 1 } }) }

    let(:game) { Game.new }

    before(:each) do
      game.start
      game.difficulty = difficulty
    end

    it 'should return true if hint was not use' do
      expect(game.present_hints?).to be_truthy
    end

    it 'should return false if hint was use' do
      game.use_hint
      expect(game.present_hints?).to be_falsey
    end
  end

  RSpec.describe Game do
    context 'easy' do
      it_behaves_like 'callable hints' do
        let(:difficulty) { :easy }
      end
    end

    context 'medium' do
      it_behaves_like 'callable hints' do
        let(:difficulty) { :medium }
      end
    end

    context 'hell' do
      it_behaves_like 'callable hints' do
        let(:difficulty) { :hell }
      end
    end
  end
end
