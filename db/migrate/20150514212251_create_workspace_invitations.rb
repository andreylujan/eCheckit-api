class CreateWorkspaceInvitations < ActiveRecord::Migration
  def change
    create_table :workspace_invitations do |t|
      t.references :workspace, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.boolean :accepted, default: false, null: false

      t.timestamps null: false
    end
  end
end
