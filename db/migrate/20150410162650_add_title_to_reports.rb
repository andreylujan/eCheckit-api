class AddTitleToReports < ActiveRecord::Migration
  def change
    add_column :reports, :title, :text, null: false
  end
end
