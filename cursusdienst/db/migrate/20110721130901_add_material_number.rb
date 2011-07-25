class AddMaterialNumber < ActiveRecord::Migration
  def up
    add_column :materials, :nr, :integer
  end

  def down
    remove_column :users, :nr
  end
end
