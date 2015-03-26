class AddReportStateAndReportTypeReferencesToReports < ActiveRecord::Migration
  def change
    add_reference :reports, :report_state, index: true, foreign_key: true
    add_reference :reports, :report_type, index: true, foreign_key: true
  end
end
