class AddReportValuesToChecklistItems < ActiveRecord::Migration
  def change
    add_column :checklist_items, :report_value, :string
  end
end
