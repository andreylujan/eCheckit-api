class RemoveColumnValueReportFromChecklistItems < ActiveRecord::Migration
  def change
    remove_column :checklist_items, :report_value, :string
  end
end
