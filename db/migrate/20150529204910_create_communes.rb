class CreateCommunes < ActiveRecord::Migration
  def change
    create_table :communes do |t|
      t.references :region, index: true, foreign_key: true, null: false
      t.text :name, null: false

      t.timestamps null: false
    end
    add_index :communes, [:region_id, :name], unique: true

  end
end
