class DropTableOrganizationUsers < ActiveRecord::Migration
  def change
    drop_table :organization_users
  end
end
