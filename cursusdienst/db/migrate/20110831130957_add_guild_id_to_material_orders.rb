class AddGuildIdToMaterialOrders < ActiveRecord::Migration
  def change
    add_column :material_orders, :guild_id, :integer
  end
end
