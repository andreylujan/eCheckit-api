class ModifyIndexOnOrganizationIdAndEmailInOrganizations < ActiveRecord::Migration
  def change

  	remove_index :domains, [ :organization_id, :domain ]
  	remove_index :domains, :email

  	add_index :domains, [ :domain ], unique: true
  	rename_column :domains, :email, :default_email
  	add_index :domains, [ :organization_id, :default_email ], unique: true
  end
end
