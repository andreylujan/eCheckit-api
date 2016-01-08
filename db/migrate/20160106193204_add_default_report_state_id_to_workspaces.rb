class AddDefaultReportStateIdToWorkspaces < ActiveRecord::Migration
  def change
    add_column :workspaces, :default_report_state_id, :integer
  end
end
