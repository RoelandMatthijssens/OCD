class FacultyInitals < ActiveRecord::Migration
  def up
    change_table :faculties do |t|
      t.string :initials
    end
  end

  def self.down
    remove_column :faculties, :initials
  end
end
