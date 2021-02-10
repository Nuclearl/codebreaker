module Validatable
  include Errors

  def validate_name!(name)
    raise LengthError if name.length < 3 || name.length > 20
  end

  def validate_guess!(guess)
    raise LengthError if guess.length != 4
    raise InputError unless guess.match(/[1-6]{4}/)
  end
end
