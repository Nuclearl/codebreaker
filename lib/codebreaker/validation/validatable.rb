module Validatable
  include Errors

  def validate_name!(name)
    raise LengthError unless (3..20).include?(name.length)
  end

  def validate_guess!(guess)
    raise InputError unless guess.match(/^[1-6]{4}$/)
  end
end
