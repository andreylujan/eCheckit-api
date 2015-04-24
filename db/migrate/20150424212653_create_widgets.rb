class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.text :name, null: false
      t.json :structure, null: false

      t.timestamps null: false
    end
  end
end
