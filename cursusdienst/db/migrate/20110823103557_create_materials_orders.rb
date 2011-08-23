class CreateMaterialsOrders < ActiveRecord::Migration
  def change
		create_table :materials_orders, :id => false do |t|
			t.integer :material_id
			t.integer :order_id

			t.timestamps
		end
  end
end
