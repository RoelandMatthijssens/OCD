class CreateBookCosts < ActiveRecord::Migration
  def change
    create_table :book_costs do |t|
      t.float :amount
      t.integer :material_id

      t.timestamps
    end
  end
end
