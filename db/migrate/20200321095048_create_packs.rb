# frozen_string_literal: true

class CreatePacks < ActiveRecord::Migration[6.0]
  def change
    create_table :packs do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
