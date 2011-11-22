class MaterialChangeOwnerToOwnerId < ActiveRecord::Migration
  def change
    rename_column :materials, :owner, :owner_id
  end
end
