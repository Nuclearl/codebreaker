require_relative 'player'
require_relative 'errors/errors'
module Codebreaker
  # include Errors

  class Game
    DIFFICULTIES = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }.freeze

    def initialize
      @range = (1..6)
      @length = 4
      @secret_code = ''
      @player = Player.new
    end

    def start
      @secret_code = @range.map(&:to_s).sample(@length).join
      @hints = @secret_code
    end

    def matrix_generator(inputed_guess)
      validate_guess!(inputed_guess)
      check_for_inclusion_in_matrix(*check_position_in_matrix(inputed_guess))
    end

    def set_hint
      hint = @hints.split('').sample
      @hints.sub!(hint, '')
      hint
    end

    def assign_difficulty(difficluty)
      @player.attempts = DIFFICULTIES[difficluty][:attempts]
      @player.hints = DIFFICULTIES[difficluty][:hints]
    end

    def assign_name(name)
      validate_name!(name)
      @player.name = name
    end

    def dec_hints
      @player.hints -= 1
    end

    def hints
      @player.hints
    end

    def dec_attempts
      @player.attempts -= 1
    end

    def attempts
      @player.attempts
    end

    private

    def check_position_in_matrix(inputed_guess)
      matrix = ''
      unnecessary_char = ''
      (0...@length).reverse_each do |index|
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
