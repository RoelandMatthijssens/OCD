class FixStupidAlphabeticalOrderError < ActiveRecord::Migration
  def change
    drop_table :guilds_disciplines
    create_table :disciplines_guilds, :id => false do |t|
      t.integer :guild_id
      t.integer :discipline_id
    end
  end
end
