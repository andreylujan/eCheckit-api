class AddIndexToReportFieldType < ActiveRecord::Migration
  def change
    add_column :report_field_types, :index, :integer
  end
end
