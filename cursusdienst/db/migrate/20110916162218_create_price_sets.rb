class CreatePriceSets < ActiveRecord::Migration
  def change
    create_table :price_sets do |t|
      t.integer :printer_id
      t.string :name

      t.timestamps
    end
  end
end
