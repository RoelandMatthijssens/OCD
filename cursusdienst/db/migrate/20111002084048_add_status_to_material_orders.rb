class AddStatusToMaterialOrders < ActiveRecord::Migration
  def change
    add_column :material_orders, :status, :string
  end
end
