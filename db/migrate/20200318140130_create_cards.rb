# frozen_string_literal: true

class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :type, null: false
      t.string :text, null: false

      t.timestamps
    end

    add_index :cards, :text, unique: true
  end
end
