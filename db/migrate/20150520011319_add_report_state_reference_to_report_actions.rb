class AddReportStateReferenceToReportActions < ActiveRecord::Migration
  def change
    add_reference :report_actions, :report_state, index: true, foreign_key: true
  end
end
