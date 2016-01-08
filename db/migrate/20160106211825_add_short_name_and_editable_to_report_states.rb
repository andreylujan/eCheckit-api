class AddShortNameAndEditableToReportStates < ActiveRecord::Migration
  def change
    add_column :report_states, :short_name, :text
    add_column :report_states, :editable, :boolean, null: false, default: false
  end
end
