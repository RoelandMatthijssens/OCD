class AddTypeToMaterials < ActiveRecord::Migration
  def change
    add_column :materials, :typee, :string
  end
end
