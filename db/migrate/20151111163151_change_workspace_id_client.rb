class ChangeWorkspaceIdClient < ActiveRecord::Migration
  def change
  	change_column :clients_doms, :workspace_id, :text
  end
end
