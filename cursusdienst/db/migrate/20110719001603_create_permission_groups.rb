class CreatePermissionGroups < ActiveRecord::Migration
  def change
    create_table :permission_groups do |t|
      t.string :name
      t.integer :level

      t.timestamps
    end
  end
end
