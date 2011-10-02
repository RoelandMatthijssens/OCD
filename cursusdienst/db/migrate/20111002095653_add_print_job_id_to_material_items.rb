class AddPrintJobIdToMaterialItems < ActiveRecord::Migration
  def change
    add_column :material_orders, :print_job_id, :integer
  end
end
