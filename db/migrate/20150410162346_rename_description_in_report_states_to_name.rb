class RenameDescriptionInReportStatesToName < ActiveRecord::Migration
  def change
  	rename_column :report_states, :description, :name
  	change_column :report_states, :name, :text, null: false
  	add_index :report_states, [ :workspace_id, :name ], unique: true
  end
end
