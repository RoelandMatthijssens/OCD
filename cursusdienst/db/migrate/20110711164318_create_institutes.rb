class CreateInstitutes < ActiveRecord::Migration
  def self.up
    create_table :institutes do |t|
      t.string :name
      t.string :initials
      t.string :location
      t.timestamps
    end
  end
  def self.down
    drop_table :institutes
  end
end
