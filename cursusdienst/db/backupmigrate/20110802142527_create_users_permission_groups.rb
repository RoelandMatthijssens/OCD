class CreateUsersPermissionGroups < ActiveRecord::Migration
  def change
		create_table :permission_groups_users, :id => false do |t|
			t.integer :permission_group_id
			t.integer :user_id

			t.timestamps
		end
  end
end
