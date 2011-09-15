class CreateActionLogs < ActiveRecord::Migration
  def change
    create_table :action_logs do |t|

      t.integer :user_id
      t.string :action

      t.timestamps
    end
  end
end
