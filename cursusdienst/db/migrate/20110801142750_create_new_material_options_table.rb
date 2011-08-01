class CreateNewMaterialOptionsTable < ActiveRecord::Migration
  def change
		drop_table :material_options
		create_table :materials_options, :id => false do |t|
			t.integer :material_id
			t.integer :option_id

			t.timestamps
		end
  end
end
