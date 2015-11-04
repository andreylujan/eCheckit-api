class AddColumnReporValueToChecklistItems < ActiveRecord::Migration
  def change
    add_column :checklist_items, :report_value, :integer
  end
end
