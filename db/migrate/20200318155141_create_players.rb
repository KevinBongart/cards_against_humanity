# frozen_string_literal: true

class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.string :token, null: false
      t.integer :position, foreign_key: true
      t.references :game, foreign_key: true

      t.timestamps
    end

    add_index :players, :token, unique: true
  end
end
