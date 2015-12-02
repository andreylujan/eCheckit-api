class RenameWorksDomsToConstructions < ActiveRecord::Migration
  def change
    rename_table :works_doms, :constructions
  end
end
