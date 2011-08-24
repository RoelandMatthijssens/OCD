class UserPasswordNameLastName < ActiveRecord::Migration
  def up
    add_column :users, :name, :string
    add_column :users, :last_name, :string
    add_column :users, :password, :string
    remove_column :users, :full_name
  end

  def down
    remove_column :users, :name, :string
    remove_column :users, :last_name, :string
    remove_column :users, :password, :string
    add_column :users, :full_name
  end
end
