class CreateTeachings < ActiveRecord::Migration
  def up
    create_table :teachings do |t|
      t.references :discipline
      t.references :subject

      t.timestamps
    end
  end

  def down
    drop_table :teachings
  end
end
