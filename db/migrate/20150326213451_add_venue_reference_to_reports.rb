class AddVenueReferenceToReports < ActiveRecord::Migration
  def change
    add_reference :reports, :venue, index: true, foreign_key: true
  end
end
