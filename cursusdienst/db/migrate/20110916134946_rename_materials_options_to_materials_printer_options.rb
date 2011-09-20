class RenameMaterialsOptionsToMaterialsPrinterOptions < ActiveRecord::Migration
  def change
    rename_table :materials_options, :extra_options_materials
    rename_table :options, :extra_options
  end
end
