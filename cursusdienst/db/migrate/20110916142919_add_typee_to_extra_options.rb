class AddTypeeToExtraOptions < ActiveRecord::Migration
  def change
    add_column :extra_options, :typee, :string
  end
end
