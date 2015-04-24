class RemoveStructureFromWidgets < ActiveRecord::Migration
  def change
    remove_column :widgets, :structure, :json
  end
end
