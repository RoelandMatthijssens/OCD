class AddTypeeToPrices < ActiveRecord::Migration
  def change
    add_column :prices, :typee, :string
  end
end
