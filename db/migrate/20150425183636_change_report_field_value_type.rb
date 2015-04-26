class ChangeReportFieldValueType < ActiveRecord::Migration
  def change
  	remove_column :report_fields, :value
  	add_column :report_fields, :value, :json, null: false
  end
end
