class CreateAssociations < ActiveRecord::Migration
  def change
    create_table :associations do |t|
      t.string :name
      t.string :initials
      t.integer :discipline_id

      t.timestamps
    end
  end
end
