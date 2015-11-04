class RemoveColumnReportValueFromChecklistItems < ActiveRecord::Migration
  def change
  	remove_column :checklist_items, :report_value
  end
end
