class DropUsersPermissions < ActiveRecord::Migration
  def up
    drop_table :users
    drop_table :permissions
  end

  def down
  end
end
