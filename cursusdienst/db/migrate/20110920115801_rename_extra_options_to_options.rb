class RenameExtraOptionsToOptions < ActiveRecord::Migration
  def change
    rename_table :extra_options_materials, :materials_options
    rename_table :extra_options, :options
  end
end
