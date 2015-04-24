class AddWidgetReferenceToReportFieldType < ActiveRecord::Migration
  def change
    add_reference :report_field_types, :widget, index: true, foreign_key: true
  end
end
