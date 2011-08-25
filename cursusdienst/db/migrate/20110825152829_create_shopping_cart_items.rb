class CreateShoppingCartItems < ActiveRecord::Migration
  def change
    create_table :shopping_cart_items do |t|
			t.integer :user_id
			t.integer :material_id
			t.integer :amount
			
      t.timestamps
    end
  end
end
