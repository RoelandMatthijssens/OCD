class CreateUsers1 < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :full_name
      t.string :user_name
      t.column :rolno, :smallint
      t.string :email
      t.integer :institution_id

      t.timestamps
    end
  end
  def self.down
    drop_table :users
  end
end
