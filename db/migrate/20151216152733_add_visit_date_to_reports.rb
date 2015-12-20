class AddVisitDateToReports < ActiveRecord::Migration
  def change
    add_column :reports, :visit_date, :datetime
  end
end
