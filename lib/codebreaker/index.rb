require_relative 'game'

game = Codebreaker::Game.new

game.start

print game.set_hint
print game.secret_code
