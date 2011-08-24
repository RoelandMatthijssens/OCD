class CreateFaculties < ActiveRecord::Migration
  def self.up
    create_table :faculties do |t|
      t.string :name
      t.integer :institute_id

      t.timestamps
    end
    add_index :faculties, :institute_id
  end
  def self.down
    drop_table :faculties
  end
end
