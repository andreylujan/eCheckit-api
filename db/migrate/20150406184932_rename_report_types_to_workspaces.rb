class RenameReportTypesToWorkspaces < ActiveRecord::Migration
  def change
    rename_table :report_types, :workspaces
  end
end
