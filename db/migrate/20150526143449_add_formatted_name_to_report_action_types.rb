class AddFormattedNameToReportActionTypes < ActiveRecord::Migration
  def change
    add_column :report_action_types, :formatted_name, :text
  end
end
