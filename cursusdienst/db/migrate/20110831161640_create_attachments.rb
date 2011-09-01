class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :material_id
      t.string :item
      t.string :content_type
      t.integer :file_size

      t.timestamps
    end
  end
end
