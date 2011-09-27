class AddDeletedToAllTheThings < ActiveRecord::Migration
  def change
    #add_column :action_logs, :deleted, :boolean, :default => false
    add_column :attachments, :deleted, :boolean, :default => false
    add_column :disciplines, :deleted, :boolean, :default => false
    add_column :faculties, :deleted, :boolean, :default => false
    add_column :guilds, :deleted, :boolean, :default => false
    add_column :info_strings, :deleted, :boolean, :default => false
    add_column :institutes, :deleted, :boolean, :default => false
    add_column :material_orders, :deleted, :boolean, :default => false
    add_column :materials, :deleted, :boolean, :default => false
    add_column :messages, :deleted, :boolean, :default => false
    add_column :options, :deleted, :boolean, :default => false
    add_column :orders, :deleted, :boolean, :default => false
    add_column :permission_groups, :deleted, :boolean, :default => false
    add_column :price_sets, :deleted, :boolean, :default => false
    add_column :prices, :deleted, :boolean, :default => false
    add_column :print_jobs, :deleted, :boolean, :default => false
    add_column :print_job_items, :deleted, :boolean, :default => false
    add_column :printers, :deleted, :boolean, :default => false
    add_column :ratings, :deleted, :boolean, :default => false
    add_column :sales, :deleted, :boolean, :default => false
    add_column :shopping_cart_items, :deleted, :boolean, :default => false
    add_column :stocks, :deleted, :boolean, :default => false
    add_column :subjects, :deleted, :boolean, :default => false
    add_column :supplies, :deleted, :boolean, :default => false
    add_column :teachings, :deleted, :boolean, :default => false
    add_column :users, :deleted, :boolean, :default => false
  end
end
