class DropTableGoogleRegion < ActiveRecord::Migration
  def change
    drop_table :google_regions
  end
end
