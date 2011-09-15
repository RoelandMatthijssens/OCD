class AddInfoToMaterials < ActiveRecord::Migration
  def change
    add_column :materials, :info, :string
  end
end
