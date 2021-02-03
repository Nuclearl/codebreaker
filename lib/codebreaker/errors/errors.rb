module Errors
  class LengthError < StandardError
    def initialize(msg = 'Incorrect length inputted')
      super
    end
  end

  class InputError < StandardError
    def initialize(msg = 'Incorrect value inputted')
      super
    end
  end
end
