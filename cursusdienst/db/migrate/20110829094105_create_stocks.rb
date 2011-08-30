class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :material_id
      t.integer :guild_id
      t.integer :amount
      t.integer :threshold
      t.integer :step
      t.string :typee
      t.integer :floating
      t.integer :floating_period

      t.timestamps
    end
  end
end
