class ChangeLongitudeAndLatitudeNullRestrictionToFalse < ActiveRecord::Migration
  def change
    change_column :reports, :latitude, :float, null: true, default: 0
    change_column :reports, :longitude, :float, null: true, default: 0
  end
end
