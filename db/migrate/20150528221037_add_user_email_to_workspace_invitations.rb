class AddUserEmailToWorkspaceInvitations < ActiveRecord::Migration
  def change
    add_column :workspace_invitations, :user_email, :text
    change_column :workspace_invitations, :user_id, :integer, null: true
    add_index :workspace_invitations, [:workspace_id, :user_email ], unique: true
  end
end
