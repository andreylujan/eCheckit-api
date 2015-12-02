class AddNameConstraintToConstructions < ActiveRecord::Migration
  def change
    change_column :constructions, :name, :text, null: false
  end
end
