class AddWelcomeMessageAndConfirmMessageToWorkspaces < ActiveRecord::Migration
  def change
    add_column :workspaces, :welcome_message, :text
    add_column :workspaces, :confirm_message, :text
  end
end
