class CreateClientsDoms < ActiveRecord::Migration
  def change
    create_table :clients_doms do |t|
      t.integer :workspace_id
      t.text :name
      t.text :rut

      t.timestamps null: false
    end
  end
end
