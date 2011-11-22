class AddBuyPriceToMaterialOrders < ActiveRecord::Migration
  def change
    add_column :material_orders, :buy_price, :float
  end
end
