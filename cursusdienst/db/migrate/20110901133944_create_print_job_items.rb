class CreatePrintJobItems < ActiveRecord::Migration
  def change
    create_table :print_job_items do |t|
			t.integer :print_job_id
			t.integer :material_id
			t.integer :amount

      t.timestamps
    end
  end
end
