class CreateMaterialOrders < ActiveRecord::Migration
  def change
    create_table :material_orders do |t|
			t.integer "order_id"
			t.integer "material_id"

      t.timestamps
    end
  end
end
