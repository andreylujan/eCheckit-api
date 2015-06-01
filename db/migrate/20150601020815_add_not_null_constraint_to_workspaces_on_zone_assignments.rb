class AddNotNullConstraintToWorkspacesOnZoneAssignments < ActiveRecord::Migration
  def change
  	change_column :zone_assignments, :workspace_id, :integer, null: false
  end
end
