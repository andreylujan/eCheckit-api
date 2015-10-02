class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.text :name, null: false
      t.references :workspace, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :checklists, [ :workspace_id, :name ], unique: true
  end
end
