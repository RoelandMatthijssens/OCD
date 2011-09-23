class AddProfToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :prof, :string
  end
end
