# frozen_string_literal: true

class AddPickToCard < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :pick, :integer
  end
end
