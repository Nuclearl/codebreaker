module Codebreaker
  include Errors

  RSpec.describe Validatable do
    include Validatable
    context '#validate_guess' do
      it 'should raise LengthError if guess length is five' do
        expect { validate_guess!('11111') }.to raise_error LengthError
      end

      it 'should raise LengthError if guess length is three' do
        expect { validate_guess!('111') }.to raise_error LengthError
      end

      it 'should raise InputError if guess contain undefined char' do
        expect { validate_guess!('1s82') }.to raise_error InputError
      end

      it 'should raise InputError if guess contain number bigger then 6' do
        expect { validate_guess!('1282') }.to raise_error InputError
      end
    end

    context '#validate_name' do
      it 'should raise LengthError if name is Ro' do
        expect { validate_name!('Ro') }.to raise_error LengthError
      end

      it 'should raise LengthError if name is WilliamWilliamWilliam' do
        expect { validate_name!('WilliamWilliamWilliam') }.to raise_error LengthError
      end
    end
  end
end
