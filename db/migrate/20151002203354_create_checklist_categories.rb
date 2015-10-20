class CreateChecklistCategories < ActiveRecord::Migration
  def change
    create_table :checklist_categories do |t|
      t.text :name, null: false
      t.references :checklist, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :checklist_categories, [ :checklist_id, :name ], unique: true
  end
end
