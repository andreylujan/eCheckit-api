class AddReasonAndChannelToReports < ActiveRecord::Migration
  def change
    add_reference :reports, :reason, index: true, foreign_key: true
    add_reference :reports, :channel, index: true, foreign_key: true
  end
end
