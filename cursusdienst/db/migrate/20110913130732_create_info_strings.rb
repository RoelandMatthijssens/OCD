class CreateInfoStrings < ActiveRecord::Migration
  def change
    create_table :info_strings do |t|
      t.string :key
      t.string :content
      t.integer :guild_id

      t.timestamps
    end
  end
end
