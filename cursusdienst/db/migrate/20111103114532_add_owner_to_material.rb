class AddOwnerToMaterial < ActiveRecord::Migration
  def change
    add_column :materials, :owner, :integer
  end
end
