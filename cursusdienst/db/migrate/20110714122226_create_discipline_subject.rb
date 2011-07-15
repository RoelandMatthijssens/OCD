class CreateDisciplineSubject < ActiveRecord::Migration
  def up
    create_table :disciplines_subjects, :id => false do |t|
      t.integer :discipline_id
      t.integer :subject_id
    end
  end

  def down
    drop_table :disciplines_subjects
  end
end
