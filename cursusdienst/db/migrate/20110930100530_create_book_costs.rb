class CreateBookCosts < ActiveRecord::Migration
  def change
    create_table :book_costs do |t|
      t.float :amount
      t.integer :supply_id
      t.boolean :deleted

      t.timestamps
    end
  end
end
