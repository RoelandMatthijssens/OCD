class AddParentToMaterials < ActiveRecord::Migration
  def change
    add_column :materials, :parent_id, :integer
  end
end
