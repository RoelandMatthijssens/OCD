class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|

      t.integer :score
      t.string :message
      t.references :user
      t.references :rateable, :polymorphic => true
      t.timestamps
    end
  end
end
