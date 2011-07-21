class AddPermissionGroupCollumn < ActiveRecord::Migration
  def up
    add_column :users, :permission_group_id, :integer
  end

  def down
    remove_column :users, :permission_group_id
  end
end
