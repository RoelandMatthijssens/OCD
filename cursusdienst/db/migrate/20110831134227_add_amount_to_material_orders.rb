class AddAmountToMaterialOrders < ActiveRecord::Migration
  def change
    add_column :material_orders, :amount, :integer
  end
end
