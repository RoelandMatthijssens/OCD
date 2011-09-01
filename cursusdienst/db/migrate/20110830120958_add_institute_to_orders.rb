class AddInstituteToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :institute_id, :integer
  end
end
