class CreateAssociationsUsers < ActiveRecord::Migration
  def change
    create_table :associations_users, :id => false do |t|
      t.integer :association_id
      t.integer :user_id
    end
  end
end
