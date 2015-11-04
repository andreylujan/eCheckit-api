class RemoveVenueIdFromReports < ActiveRecord::Migration
  def change
    remove_column :reports, :venue_id, :integer
  end
end
