class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|

      t.integer :user_id
      t.integer :guild_id
      t.string :order_key 	#for humanoid reference 
      t.string :status			#for status of payment(pending/payed/cancles/payingcash)
      

      t.timestamps
    end
  end
end
