class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.references :association
      t.references :material

      t.timestamps
    end
  end
end
