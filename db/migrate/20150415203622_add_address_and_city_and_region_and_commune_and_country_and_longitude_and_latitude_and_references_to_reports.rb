class AddAddressAndCityAndRegionAndCommuneAndCountryAndLongitudeAndLatitudeAndReferencesToReports < ActiveRecord::Migration
  def change
    add_column :reports, :address, :text
    add_column :reports, :city, :text
    add_column :reports, :region, :text
    add_column :reports, :commune, :text
    add_column :reports, :country, :text
    add_column :reports, :longitude, :float, null: false
    add_column :reports, :latitude, :float, null: false
    add_column :reports, :reference, :text
  end
end
