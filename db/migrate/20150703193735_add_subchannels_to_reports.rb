class AddSubchannelsToReports < ActiveRecord::Migration
  def change
    add_reference :reports, :subchannel, index: true, foreign_key: true
  end
end
