# frozen_string_literal: true

class AddRandoToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :rando, :boolean, default: false
  end
end
