require_relative 'game'

game = Codebreaker::Game.new

game.start

game.assign_difficulty(:hell)
puts game.set_hint
puts game.hints

puts game.present_hints

puts game.set_hint
puts game.hints

puts game.present_hints
