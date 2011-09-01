class RemoveGuildIdFromOrders < ActiveRecord::Migration
  def up
    remove_column :orders, :guild_id
  end

  def down
    add_column :orders, :guild_id, :integer
  end
end
