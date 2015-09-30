class AddInternalIdToReports < ActiveRecord::Migration
  def change
    add_column :reports, :internal_id, :text
    Report.reset_column_information
    Report.all.each do |r|
        r.update_attribute :internal_id, SecureRandom.uuid
    end
    change_column :reports, :internal_id, :text, null: false
    add_index :reports, :internal_id, unique: true
  end
end
