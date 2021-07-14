RSpec.describe Validatable do
  let(:dummy_class) { Class.new { extend Validatable } }

  context '#validate_guess' do
    context 'LengthError' do
      it 'should raise LengthError if guess length is five' do
        expect { dummy_class.validate_guess!('11111') }.to raise_error Errors::InputError
      end

      it 'should raise LengthError if guess length is three' do
        expect { dummy_class.validate_guess!('111') }.to raise_error Errors::InputError
      end
    end
  end

  context '#validate_guess' do
    context 'InputError' do
      it 'should raise InputError if guess contain undefined char' do
        expect { dummy_class.validate_guess!('1s82') }.to raise_error Errors::InputError
      end

      it 'should raise InputError if guess contain number bigger then 6' do
        expect { dummy_class.validate_guess!('1282') }.to raise_error Errors::InputError
      end

      it 'should raise InputError if guess contain zero number' do
        expect { dummy_class.validate_guess!('1082') }.to raise_error Errors::InputError
      end
    end
  end
end
