class ChangeDefaultPermissionInUsers < ActiveRecord::Migration
  def change
    change_column(:users, :permission_group_id, :integer, :default => 0)
  end
end
