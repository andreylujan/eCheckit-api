class AddDefaultDataValue < ActiveRecord::Migration
  def change
  	change_column :report_actions, :data, :json, null: false, default: {}
  end
end
