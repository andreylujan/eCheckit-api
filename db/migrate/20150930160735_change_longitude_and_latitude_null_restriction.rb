class ChangeLongitudeAndLatitudeNullRestriction < ActiveRecord::Migration
  def change
    change_column :reports, :latitude, :float, default: 0
    change_column :reports, :longitude, :float, default: 0
  end
end
