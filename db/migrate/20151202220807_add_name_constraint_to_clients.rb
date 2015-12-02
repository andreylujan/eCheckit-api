class AddNameConstraintToClients < ActiveRecord::Migration
  def change
    change_column :clients, :name, :text, null: false
  end
end
