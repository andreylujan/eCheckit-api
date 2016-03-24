class AddDeletedAtToConstructions < ActiveRecord::Migration
  def change
    add_column :constructions, :deleted_at, :datetime
    add_index :constructions, :deleted_at
  end
end
