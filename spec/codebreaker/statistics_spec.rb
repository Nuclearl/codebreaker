module Codebreaker
  RSpec.describe Statistics do
    context '.statistics' do
      it 'returns correct values' do
        test_games = []
        [['name1', 4, 1, :easy], ['name1', 3, 0, :medium], ['name1', 4, 1, :hell], ['name1', 11, 2, :easy],
         ['name2', 2, 1, :easy], ['name2', 2, 1, :easy], ['name2', 3, 0, :hell], ['name2', 4, 0, :easy],
         ['name3', 4, 0, :hell], ['name3', 7, 0, :medium], ['name3', 13, 0, :easy], ['name4', 3, 1, :medium],
         ['name4', 9, 0, :easy]].each do |name, attempts, hints, difficulty|
          test_game = Game.new
          test_game.difficulty = difficulty
          test_game.name = name
          test_game.instance_variable_set(:@attempts, attempts)
          test_game.instance_variable_set(:@hints, hints)
          test_games << test_game
        end
        expected_values = [
          [1, 'name2', 2, 11, 3, 2, 0], [2, 'name3', 2, 24, 4, 0, 0], [3, 'name1', 2, 22, 4, 4, 1],
          [4, 'name1', 1, 22, 3, 4, 0], [5, 'name4', 1, 12, 3, 1, 1], [6, 'name3', 1, 24, 7, 0, 0],
          [7, 'name2', 0, 11, 2, 2, 1], [8, 'name2', 0, 11, 2, 2, 1], [9, 'name2', 0, 11, 4, 2, 0],
          [10, 'name1', 0, 22, 4, 4, 1], [11, 'name4', 0, 12, 9, 1, 0], [12, 'name1', 0, 22, 11, 4, 2],
          [13, 'name3', 0, 24, 13, 0, 0]
        ]
        expect(Statistics.statistics(test_games)).to eq expected_values
      end
    end
  end
end
