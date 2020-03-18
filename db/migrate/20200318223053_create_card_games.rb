class CreateCardGames < ActiveRecord::Migration[6.0]
  def change
    create_table :card_games do |t|
      t.references :card, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.boolean :used, default: false
      t.integer :position, null: false

      t.timestamps
    end
  end
end
