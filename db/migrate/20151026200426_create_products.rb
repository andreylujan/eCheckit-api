class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text :name
      t.float :price

      t.timestamps null: false
    end
  end
end
