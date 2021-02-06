require_relative 'errors/errors'
module Codebreaker
  class Game
    attr_reader :secret_code, :difficulty, :attempts, :hints, :name

    RANGE_SECRET_CODE = (1..6).freeze
    LENGTH_SECRET_CODE = 4

    DIFFICULTIES = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }.freeze

    def initialize
      @secret_code = ''
      @name = ''
      @attempts = 0
      @hints = 0
      @difficulty = 0
    end

    def start
      @secret_code = RANGE_SECRET_CODE.map(&:to_s).sample(LENGTH_SECRET_CODE).join
      @available_hints = @secret_code.dup
    end

    def matrix_generator(inputed_guess)
      validate_guess!(inputed_guess)
      check_for_inclusion_in_matrix(*check_position_in_matrix(inputed_guess))
    end

    def set_hint
      hint = @available_hints.split('').sample
      @available_hints.sub!(hint, '')
      @hints -= 1
      hint
    end

    def assign_difficulty(difficulty)
      @attempts = DIFFICULTIES[difficulty][:attempts]
      @hints = DIFFICULTIES[difficulty][:hints]
      @difficulty = DIFFICULTIES.keys().index(difficulty)
    end

    def assign_name(name)
      validate_name!(name)
      @name = name
    end

    def dec_attempts
      @attempts -= 1
    end

    def present_hints
      @hints.positive?
    end

    def present_attempts
      @attempts.positive?
    end

    private

    def check_position_in_matrix(inputed_guess)
      matrix = ''
      unnecessary_char = ''
      (0...LENGTH_SECRET_CODE).reverse_each do |index|
        next unless inputed_guess[index] == @secret_code[index]

        matrix += '+'
        unnecessary_char += inputed_guess.slice!(index)
      end
      [matrix, unnecessary_char, inputed_guess]
    end

    def check_for_inclusion_in_matrix(matrix, unnecessary_char, inputed_guess)
      unless inputed_guess.empty?
        inputed_guess.each_char do |char|
          next unless @secret_code.include?(char) && !unnecessary_char.include?(char)

          matrix += '-'
          inputed_guess.delete!(char)
          unnecessary_char += char
        end
      end
      matrix
    end

    def validate_name!(name)
      raise Errors::LengthError if name.length < 3 || name.length > 20
    end

    def validate_guess!(guess)
      raise Errors::LengthError if guess.length != 4
      raise Errors::InputError unless guess.match(/[1-6]+/)
    end
  end
end
