class AddPackToCard < ActiveRecord::Migration[6.0]
  def change
    add_reference :cards, :pack, null: false, foreign_key: true, index: true
  end
end
