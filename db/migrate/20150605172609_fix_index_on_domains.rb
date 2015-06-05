class FixIndexOnDomains < ActiveRecord::Migration
  def change
  	remove_index :domains, [ :organization_id, :default_email ]
  	add_index :domains, [ :domain, :default_email ], unique: true
  end
end
