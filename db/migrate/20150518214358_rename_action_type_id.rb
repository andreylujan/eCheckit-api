class RenameActionTypeId < ActiveRecord::Migration
  def change
    rename_column :report_actions, :action_type_id, :report_action_type_id
  end
end
