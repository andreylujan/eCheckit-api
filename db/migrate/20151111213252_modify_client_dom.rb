class ModifyClientDom < ActiveRecord::Migration
  def change
  	change_column :clients_doms, :workspace_id, 'integer USING CAST(workspace_id AS integer)'
  end
end
