class RenameContactDomsToContacts < ActiveRecord::Migration
  def change
    rename_table :contact_doms, :contacts
  end
end
