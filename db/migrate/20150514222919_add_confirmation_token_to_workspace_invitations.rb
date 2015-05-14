class AddConfirmationTokenToWorkspaceInvitations < ActiveRecord::Migration
  def change
    add_column :workspace_invitations, :confirmation_token, :text, null: false
  end
end
