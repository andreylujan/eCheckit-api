class RenameActionsToReportActions < ActiveRecord::Migration
  def change
    rename_table :actions, :report_actions
  end
end
