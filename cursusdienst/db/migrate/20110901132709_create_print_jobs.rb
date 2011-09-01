class CreatePrintJobs < ActiveRecord::Migration
  def change
    create_table :print_jobs do |t|
			t.string :status

      t.timestamps
    end
  end
end
