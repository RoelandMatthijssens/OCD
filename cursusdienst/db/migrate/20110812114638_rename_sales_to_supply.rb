class RenameSalesToSupply < ActiveRecord::Migration
  def up
		drop_table :sales
    create_table :supplies do |t|
      t.references :guild
      t.references :material

      t.timestamps
    end
  end

  def down
		drop_table :supplies
    create_table :sales do |t|
      t.references :guild
      t.references :material

      t.timestamps
    end
  end
end
