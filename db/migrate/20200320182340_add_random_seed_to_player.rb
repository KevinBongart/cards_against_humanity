class AddRandomSeedToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :random_seed, :string
  end
end
