class DropTableGoogleCommune < ActiveRecord::Migration
  def change
    drop_table :google_communes
  end
end
