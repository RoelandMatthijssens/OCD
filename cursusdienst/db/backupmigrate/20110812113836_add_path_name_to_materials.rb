class AddPathNameToMaterials < ActiveRecord::Migration
  def change
    add_column :materials, :path_name, :string
  end
end
