class AddNameToOptions < ActiveRecord::Migration
  def change
    add_column :options, :name, :string
    remove_column :options, :key, :value
  end
end
