class AddDataToReportFieldTypes < ActiveRecord::Migration
  def change
    add_column :report_field_types, :data, :json
  end
end
