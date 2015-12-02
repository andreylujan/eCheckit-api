class AddUniqueIdToConstructions < ActiveRecord::Migration
  def change
    add_column :constructions, :unique_id, :integer, null: false
    add_index :constructions, [ :client_id, :unique_id ], unique: true
  end
end
