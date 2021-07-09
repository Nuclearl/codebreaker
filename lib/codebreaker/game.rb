require_relative 'validation/errors'
require_relative 'validation/validatable'

module Codebreaker
  class Game
    include Validatable

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

    def matrix_generator(inputted_guess)
      validate_guess!(inputted_guess)
      @attempts += 1
      check_position_in_matrix(inputted_guess)
    end

    def set_hint
      return ' ' if @available_hints.empty?

      hint = @available_hints.chars.sample
      @available_hints.sub!(hint, '')
      @hints += 1
      hint
    end

    def assign_difficulty(difficulty)
      @difficulty = DIFFICULTIES.keys.index(difficulty)
    end

    def assign_name(name)
      validate_name!(name)
      @name = name
    end

    def present_hints
      @hints < DIFFICULTIES.values[difficulty][:hints]
    end

    def present_attempts
      @attempts < DIFFICULTIES.values[difficulty][:attempts]
    end

    private

    def check_position_in_matrix(inputted_guess)
      matrix = ''
      unnecessary_char = ''
      (0...LENGTH_SECRET_CODE).reverse_each do |index|
        next unless inputted_guess[index] == @secret_code[index]

        matrix += '+'
        unnecessary_char += inputted_guess.slice!(index)
      end
      check_for_inclusion_in_matrix(inputted_guess, matrix, unnecessary_char)
    end

    def check_for_inclusion_in_matrix(inputted_guess, matrix = '', unnecessary_char = '')
      unless inputted_guess.empty?
        inputted_guess.each_char do |char|
          next unless @secret_code.include?(char) && !unnecessary_char.include?(char)

          matrix += '-'
          inputted_guess.delete!(char)
          unnecessary_char += char
        end
      end
      matrix
    end
  end
end
