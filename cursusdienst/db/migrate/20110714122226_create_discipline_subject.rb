class CreateDisciplineSubject < ActiveRecord::Migration
  def up
    create_table :disciplines_subjects, :id => false do |t|
      t.references :discipline
      t.references :subject
    end
  end

  def down
    drop_table :disciplines_subjects
  end
end
