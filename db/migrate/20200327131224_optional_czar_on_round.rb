class OptionalCzarOnRound < ActiveRecord::Migration[6.0]
  def up
    change_column :rounds, :czar_id, :integer, null: true
  end

  def down
    change_column :rounds, :czar_id, :integer, null: false
  end
end
