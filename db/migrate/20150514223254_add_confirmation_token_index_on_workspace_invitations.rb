class AddConfirmationTokenIndexOnWorkspaceInvitations < ActiveRecord::Migration
  def change
  	add_index :workspace_invitations, :confirmation_token, unique: true
  end
end
