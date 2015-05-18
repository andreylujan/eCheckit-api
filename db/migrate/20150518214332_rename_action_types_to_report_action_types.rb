class RenameActionTypesToReportActionTypes < ActiveRecord::Migration
  def change
    rename_table :action_types, :report_action_types
  end
end
