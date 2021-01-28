module Codebreaker
  class Game
    def initialize
      @range = (1..6)
      @length = 4
      @secret_code = ''
    end

    def start
      @secret_code = @range.map(&:to_s).sample(@length).join
      @hints = @secret_code
    end

    def matrix_generator(inputed_guess)
      check_for_inclusion_in_matrix(*check_position_in_matrix(inputed_guess))
    end

    def set_hint
      hint = @hints.split('').sample
      @hints.sub!(hint, '')
      hint
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
  end
end
