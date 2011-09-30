class AddPriceToMaterialOrder < ActiveRecord::Migration
  def change
    add_column :material_orders, :price, :float
  end
end
