class RenameDescriptionInWorkspacesToName < ActiveRecord::Migration
  def change
  	rename_column :workspaces, :description, :name
  end
end
