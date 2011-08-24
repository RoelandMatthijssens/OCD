class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :user_id
      t.integer :material_id
      t.integer :status
      t.integer :reference_key

      t.timestamps
    end
  end
end
