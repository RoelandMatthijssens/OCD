class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :user_name
      t.column :rolno, :smallint
      t.string :email
      t.string :institution

      t.timestamps
    end
  end
end
