class AddPageCountToMaterial < ActiveRecord::Migration
  def up
    add_column :materials, :page_count, :integer, :default => -1
    add_column :materials, :printable, :boolean
    remove_column :materials, :price
    add_column :supplies, :price_set_id, :integer
    add_column :supplies, :price, :float
  end

  def down
    remove_column :materials, :page_count
    remove_column :materials, :printable
    add_column :materials, :price, :integer
    remove_column :supplies, :price_set_id
    remove_column :supplies, :price
  end

end
