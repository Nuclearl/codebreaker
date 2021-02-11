RSpec.describe Validatable do
  let(:dummy_class) { Class.new { extend Validatable } }

  context '#validate_name' do
    it 'should raise LengthError if name is Ro' do
      expect { dummy_class.validate_name!('Ro') }.to raise_error Errors::LengthError
    end

    it 'should raise LengthError if name is WilliamWilliamWilliam' do
      expect { dummy_class.validate_name!('WilliamWilliamWilliam') }.to raise_error Errors::LengthError
    end
  end
end
