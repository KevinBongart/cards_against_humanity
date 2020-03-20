# frozen_string_literal: true

class CreateRounds < ActiveRecord::Migration[6.0]
  def change
    create_table :rounds do |t|
      t.references :game, null: false, foreign_key: true
      t.string :status
      t.integer :position, null: false
      t.integer :czar_id, null: false
      t.integer :black_card_id

      t.timestamps
    end
  end
end
