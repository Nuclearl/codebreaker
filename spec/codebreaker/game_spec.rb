require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    before do
      game.start
    end

    context '#start' do
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

    context '#matrix_generator' do
      it 'should inscrements attemts by one' do
        expect { game.matrix_generator('1111') }.to change { game.attempts }.by(1)
      end

      [['6543', '5643', '++--'],
       ['6543', '6411', '+-'],
       ['6543', '6544', '+++'],
       ['6543', '3456', '----'],
       ['6543', '6666', '+'],
       ['6543', '2666', '-'],
       ['6543', '2222', ''],
       ['6666', '1661', '++'],
       ['1234', '3124', '+---'],
       ['1234', '1524', '++-'],
       ['1234', '1234', '++++']].each do |secret_code, guess, expected|
        it "should return #{expected} when the secret key is #{secret_code} and the guess is #{guess}" do
          game.instance_variable_set(:@secret_code, secret_code)
          expect(game.matrix_generator(guess)).to eq expected
          # allow(game1).to receive(:matrix_generator).with(guess).and_return(expected)
        end
      end
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

    context '#present_hints' do
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

      it 'should return true if hint was not use and difficulty is medium' do
        game.assign_difficulty(:medium)
        expect(game.present_hints).to be_truthy
      end

      it 'should return false if hint was use one time and difficulty is medium' do
        game.assign_difficulty(:medium)
        game.set_hint
        expect(game.present_hints).to be_falsey
      end

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

    context '#present_attempts' do
      it 'should return true if attempt was not use and difficulty is easy' do
        game.assign_difficulty(:easy)
        expect(game.present_attempts).to be_truthy
      end

      it 'should return true if attempt was use one time and difficulty is easy' do
        game.assign_difficulty(:easy)
        game.matrix_generator('1111')
        expect(game.present_attempts).to be_truthy
      end

      it 'should return false if attempt was use fifteen times and difficulty is easy' do
        game.assign_difficulty(:easy)
        15.times { game.matrix_generator('1111') }
        expect(game.present_attempts).to be_falsey
      end

      it 'should return true if attempt was not use and difficulty is medium' do
        game.assign_difficulty(:medium)
        expect(game.present_attempts).to be_truthy
      end

      it 'should return true if attempt was use one time and difficulty is medium' do
        game.assign_difficulty(:medium)
        game.matrix_generator('1111')
        expect(game.present_attempts).to be_truthy
      end

      it 'should return false if attempt was use ten times and difficulty is medium' do
        game.assign_difficulty(:medium)
        10.times { game.matrix_generator('1111') }
        expect(game.present_attempts).to be_falsey
      end

      it 'should return true if attempt was not use and difficulty is hell' do
        game.assign_difficulty(:hell)
        expect(game.present_attempts).to be_truthy
      end

      it 'should return true if attempt was use one time and difficulty is hell' do
        game.assign_difficulty(:hell)
        game.matrix_generator('1111')
        expect(game.present_attempts).to be_truthy
      end

      it 'should return false if attempt was use five times and difficulty is hell' do
        game.assign_difficulty(:hell)
        5.times { game.matrix_generator('1111') }
        expect(game.present_attempts).to be_falsey
      end
    end

    context '#statistics' do
      it 'returns correct values' do
        test_games = []
        [['name1', 4, 1, :easy],
         ['name1', 3, 0, :medium],
         ['name1', 4, 1, :hell],
         ['name1', 11, 2, :easy],
         ['name2', 2, 1, :easy],
         ['name2', 2, 1, :easy],
         ['name2', 3, 0, :hell],
         ['name2', 4, 0, :easy],
         ['name3', 4, 0, :hell],
         ['name3', 7, 0, :medium],
         ['name3', 13, 0, :easy],
         ['name4', 3, 1, :medium],
         ['name4', 9, 0, :easy]].each do |name, attempts, hints, difficulty|
          test_game = Game.new
          test_game.assign_difficulty(difficulty)
          test_game.assign_name(name)
          test_game.instance_variable_set(:@attempts, attempts)
          test_game.instance_variable_set(:@hints, hints)
          test_games << test_game
        end
        expected_values = [
          [1, 'name2', 2, 11, 3, 2, 0],
          [2, 'name3', 2, 24, 4, 0, 0],
          [3, 'name1', 2, 22, 4, 4, 1],
          [4, 'name1', 1, 22, 3, 4, 0],
          [5, 'name4', 1, 12, 3, 1, 1],
          [6, 'name3', 1, 24, 7, 0, 0],
          [7, 'name2', 0, 11, 2, 2, 1],
          [8, 'name2', 0, 11, 2, 2, 1],
          [9, 'name2', 0, 11, 4, 2, 0],
          [10, 'name1', 0, 22, 4, 4, 1],
          [11, 'name4', 0, 12, 9, 1, 0],
          [12, 'name1', 0, 22, 11, 4, 2],
          [13, 'name3', 0, 24, 13, 0, 0]
        ]
        expect(game.statistics(test_games)).to eq expected_values
      end
    end
  end
end
