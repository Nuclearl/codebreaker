require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }

    context '#start' do
      before do
        game.start
      end

      it 'saves secret code' do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end

      it 'saves 4 numbers secret code' do
        expect(game.instance_variable_get(:@secret_code).size).to eq 4
      end

      it 'saves secret code with numbers from 1 to 6' do
        expect(game.instance_variable_get(:@secret_code)).to match(/[1-6]+/)
      end
    end

    context '#matrix generator' do
      it 'generation of a fair matrix' do
        Matrix::MATRIX.each do |secret_code, input, expected|
          game1 = double('game', secret_code: secret_code)
          allow(game1).to receive(:matrix_generator).with(input).and_return(expected)
        end
      end
    end
  end
end
