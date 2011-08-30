class AddGuildIdToShoppingCartItems < ActiveRecord::Migration
  def change
    add_column :shopping_cart_items, :guild_id, :integer
  end
end
