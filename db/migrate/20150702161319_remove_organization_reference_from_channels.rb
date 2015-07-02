class RemoveOrganizationReferenceFromChannels < ActiveRecord::Migration
  def change
  	remove_column :channels, :organization_id
  end
end
