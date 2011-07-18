class CreateMaterialOptions < ActiveRecord::Migration
  def change
    create_table :material_options do |t|
      t.string :key
      t.string :value
      t.integer :material_id

      t.timestamps
    end
  end
end
