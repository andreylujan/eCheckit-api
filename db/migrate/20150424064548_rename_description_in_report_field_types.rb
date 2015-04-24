class RenameDescriptionInReportFieldTypes < ActiveRecord::Migration
  def change
  	rename_column :report_field_types, :description, :name
  end
end
