class CreateGoogleRegions < ActiveRecord::Migration
  def change
    create_table :google_regions do |t|
      t.text :region
      t.text :google_region

      t.timestamps null: false
    end
  end
end
