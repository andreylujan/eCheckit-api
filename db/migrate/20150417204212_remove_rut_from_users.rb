class RemoveRutFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :rut, :text
  end
end
