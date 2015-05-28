class RequireUserEmailForWorkspaceInvitations < ActiveRecord::Migration
  def change
    change_column :workspace_invitations, :user_email, :text, null: false
  end
end
