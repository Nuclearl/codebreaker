require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    before do
      game.start
    end

    context '#assign_difficulty' do
      it 'if difficulty easy @difficulty is 0' do
        game.difficulty = :easy
        expect(game.difficulty).to eq 0
      end

      it 'if difficulty medium @difficulty is 1' do
        game.difficulty = :medium
        expect(game.difficulty).to eq 1
      end

      it 'if difficulty hell @difficulty is 2' do\
        game.difficulty = :hell
        expect(game.difficulty).to eq 2
      end
    end

    context '#assign_name' do
      it 'should assign name' do
        name = FFaker::Name.name
        game.name = name
        expect(game.name).to eq name
      end
    end
  end
end
