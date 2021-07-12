require_relative 'game'

game = Codebreaker::Game.new
game.start

game.assign_difficulty(:hell)

game.matrix_generator('1234')
