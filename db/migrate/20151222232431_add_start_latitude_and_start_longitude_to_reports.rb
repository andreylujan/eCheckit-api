class AddStartLatitudeAndStartLongitudeToReports < ActiveRecord::Migration
  def change
    add_column :reports, :start_latitude, :float
    add_column :reports, :start_longitude, :float
  end
end
