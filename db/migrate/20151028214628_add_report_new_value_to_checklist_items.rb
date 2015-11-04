class AddReportNewValueToChecklistItems < ActiveRecord::Migration
  def change
    add_column :checklist_items, :report_value, :text
  end
end
