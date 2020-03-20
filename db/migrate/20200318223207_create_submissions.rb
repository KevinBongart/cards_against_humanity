# frozen_string_literal: true

class CreateSubmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :submissions do |t|
      t.references :player, null: false, foreign_key: true
      t.references :round, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true
      t.boolean :won, null: false, default: false
      t.integer :position, null: false

      t.timestamps
    end
  end
end
