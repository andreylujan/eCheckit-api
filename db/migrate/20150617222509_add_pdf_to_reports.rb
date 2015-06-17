class AddPdfToReports < ActiveRecord::Migration
  def change
    add_column :reports, :pdf, :text
  end
end
