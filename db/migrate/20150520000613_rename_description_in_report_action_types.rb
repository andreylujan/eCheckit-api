class RenameDescriptionInReportActionTypes < ActiveRecord::Migration
  def change
  	rename_column :report_action_types, :description, :name
  end
end
