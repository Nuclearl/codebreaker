require_relative 'game'

game = Codebreaker::Game.new

game.start

print game.secret_code
