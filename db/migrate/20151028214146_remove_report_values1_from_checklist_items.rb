class RemoveReportValues1FromChecklistItems < ActiveRecord::Migration
  def change
    remove_column :checklist_items, :report_value
  end
end
