# frozen_string_literal: true
class AddExpandHandToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :expand_hand, :boolean, default: false
  end
end
