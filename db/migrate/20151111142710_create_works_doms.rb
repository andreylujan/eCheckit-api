class CreateWorksDoms < ActiveRecord::Migration
  def change
    create_table :works_doms do |t|
      t.integer :client_id
      t.text :name
      t.text :address

      t.timestamps null: false
    end
  end
end
