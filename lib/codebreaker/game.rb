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

    def matrix_generator(inputed_guess)
      validate_guess!(inputed_guess)
      @attempts += 1
      check_for_inclusion_in_matrix(*check_position_in_matrix(inputed_guess))
    end

    def set_hint
      return ' ' if @available_hints.empty?

      hint = @available_hints.split('').sample
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

    def statistics(games)
      games = games.sort_by(&:hints).sort_by(&:attempts).sort_by { |game| -game.difficulty }
      grouping_statistics(games)
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

    def get_total_results(games)
      games.group_by(&:name).transform_values do |grouped_games|
        { attemts: grouped_games.collect(&:attempts).sum, hints: grouped_games.collect(&:hints).sum }
      end
    end

    def grouping_statistics(games)
      total_results = get_total_results(games)
      games.each_with_index.map do |game, index, name = game.name|
        [index + 1, name, game.difficulty, total_results[name][:attemts], game.attempts, total_results[name][:hints],
         game.hints]
      end
    end
  end
end
