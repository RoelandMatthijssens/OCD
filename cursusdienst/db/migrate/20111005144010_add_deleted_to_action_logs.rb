class AddDeletedToActionLogs < ActiveRecord::Migration
  def change
    add_column :action_logs, :deleted, :bool
  end
end
