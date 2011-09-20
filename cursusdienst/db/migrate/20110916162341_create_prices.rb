class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :price_set_id
      t.integer :extra_option_id
      t.float :amount

      t.timestamps
    end
  end
end
