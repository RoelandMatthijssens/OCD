class CreateDisciplinesUsers < ActiveRecord::Migration
  def change
    create_table :disciplines_users, :id => false do |t|
      t.integer :user_id
      t.integer :discipline_id
    end
  end
end
