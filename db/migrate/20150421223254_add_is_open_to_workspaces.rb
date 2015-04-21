class AddIsOpenToWorkspaces < ActiveRecord::Migration
  def change
    add_column :workspaces, :is_open, :boolean, null: false, default: true
  end
end
