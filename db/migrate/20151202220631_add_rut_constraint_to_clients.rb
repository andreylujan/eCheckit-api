class AddRutConstraintToClients < ActiveRecord::Migration
  def change
    change_column :clients, :rut, :text, null: false
    add_index :clients, :rut, unique: true
  end
end
