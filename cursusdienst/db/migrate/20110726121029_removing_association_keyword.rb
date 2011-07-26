class RemovingAssociationKeyword < ActiveRecord::Migration
  def change
    drop_table :associations
    drop_table :associations_disciplines
    drop_table :associations_users
    
    create_table :guilds do |t|
      t.string :name
      t.string :initials
      t.integer :discipline_id
    end
    
    create_table :guilds_users, :id => false do |t|
      t.integer :guild_id
      t.integer :user_id
    end
    
    create_table :guilds_disciplines, :id => false do |t|
      t.integer :guild_id
      t.integer :user_id
    end
    
    remove_column :sales, :association_id
    add_column :sales, :guild_id, :integer
  end
end
