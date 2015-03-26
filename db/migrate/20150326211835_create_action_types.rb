class CreateActionTypes < ActiveRecord::Migration
  def change
    create_table :action_types do |t|
      t.text :description
      t.references :organization, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
