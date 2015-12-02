class AddEmailToWorkspaces < ActiveRecord::Migration
  def change
    add_column :workspaces, :email, :text
  end
end
