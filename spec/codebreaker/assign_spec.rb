require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    before do
      game.start
    end

    context '#assign_difficulty' do
      it 'if difficulty easy @difficulty is 0' do
        game.assign_difficulty(:easy)
        expect(game.difficulty).to eq 0
      end

      it 'if difficulty medium @difficulty is 1' do
        game.assign_difficulty(:medium)
        expect(game.difficulty).to eq 1
      end

      it 'if difficulty hell @difficulty is 2' do
        game.assign_difficulty(:hell)
        expect(game.difficulty).to eq 2
      end
    end

    context '#assign_name' do
      it 'should assign name Tom' do
        game.assign_name('Tom')
        expect(game.name).to eq 'Tom'
      end
    end
  end
end
