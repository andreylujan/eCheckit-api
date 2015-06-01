class AddWorkspaceReferenceToZoneAssignments < ActiveRecord::Migration
  def change
    add_reference :zone_assignments, :workspace, index: true, foreign_key: true
  end
end
