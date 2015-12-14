class AddStartDateAndFinishDateAndFinishLatitudeAndFinishLongitudeToReports < ActiveRecord::Migration
  def change
    add_column :reports, :start_date, :datetime
    add_column :reports, :finish_date, :datetime
    add_column :reports, :finish_latitude, :float
    add_column :reports, :finish_longitude, :float
  end
end
