class AddPriceToPrintJobs < ActiveRecord::Migration
  def change
    add_column :print_jobs, :price, :float
  end
end
