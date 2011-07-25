class CreateAssociationsDisciplines < ActiveRecord::Migration
  def change
    create_table :associations_disciplines, :id => false do |t|
      t.integer :association_id
      t.integer :discipline_id
    end
  end
end
