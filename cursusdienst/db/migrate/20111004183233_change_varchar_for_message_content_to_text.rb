class ChangeVarcharForMessageContentToText < ActiveRecord::Migration
  def up
    change_column :messages, :content, :text
    change_column :info_strings, :content, :text
  end

  def down
    change_column :messages, :content, :string
    change_column :info_strings, :content, :string
  end
end
