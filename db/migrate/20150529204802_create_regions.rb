class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.text :name, null: false
      t.text :roman_numeral, null: false

      t.timestamps null: false
    end

    add_index :regions, :name, unique: true
    add_index :regions, :roman_numeral, unique: true
  end
end
