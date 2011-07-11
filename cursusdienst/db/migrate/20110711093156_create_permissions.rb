class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :name
      t.column :level, :smallint
      t.timestamps
    end
  end
end
