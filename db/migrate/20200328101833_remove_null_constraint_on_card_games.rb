# frozen_string_literal: true

class RemoveNullConstraintOnCardGames < ActiveRecord::Migration[6.0]
  def up
    change_column :card_games, :position, :integer, null: true
  end

  def down
    change_column :card_games, :position, :integer, null: false
  end
end
