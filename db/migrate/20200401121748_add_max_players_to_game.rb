# frozen_string_literal: true

class AddMaxPlayersToGame < ActiveRecord::Migration[6.0]
  def up
    add_column :games, :max_players, :integer, default: 0, null: false

    Game.find_each do |game|
      game.update!(max_players: game.players.count)
    end
  end

  def down
    remove_column :games, :max_players
  end
end
