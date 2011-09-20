class AddOptionIdToPrice < ActiveRecord::Migration
  def change
    add_column :prices, :option_id, :integer
    remove_column :prices, :extra_option_id
  end
end
