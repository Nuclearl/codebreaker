require_relative 'game'

game = Codebreaker::Game.new

game.start

print game.matrix_generator('1234')
