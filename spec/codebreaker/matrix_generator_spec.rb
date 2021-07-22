module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    before do
      game.start
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
        end
      end
    end
  end
end
