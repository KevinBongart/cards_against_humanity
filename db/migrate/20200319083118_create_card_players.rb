class CreateCardPlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :card_players do |t|
      t.references :card, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.integer :position, null: false

      t.timestamps
    end
  end
end
