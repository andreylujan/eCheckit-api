class CreateReasons < ActiveRecord::Migration
  def change
    create_table :reasons do |t|
      t.references :workspace, index: true, foreign_key: true
      t.text :name, null: false
      t.text :image

      t.timestamps null: false
    end
  end
end
