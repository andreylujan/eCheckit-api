class AddEditableToReportFields < ActiveRecord::Migration
  def change
    add_column :report_fields, :editable, :boolean, null: false, default: false
  end
end
