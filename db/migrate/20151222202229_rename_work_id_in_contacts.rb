class RenameWorkIdInContacts < ActiveRecord::Migration
  def change
  	rename_column :contacts, :work_id, :construction_id
  end
end
