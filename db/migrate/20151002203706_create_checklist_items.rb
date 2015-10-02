class CreateChecklistItems < ActiveRecord::Migration
  def change
    create_table :checklist_items do |t|
      t.references :checklist_category, index: true, foreign_key: true
      t.text :name, null: false

      t.timestamps null: false
    end
    add_index :checklist_items, [ :checklist_category_id, :name ], unique: true
  end
end
