class RemoveDirectManagerIdAndIndirectManagerIdFromSubchannels < ActiveRecord::Migration
  def change
    remove_column :subchannels, :direct_manager_id, :integer
    remove_column :subchannels, :indirect_manager_id, :integer
  end
end
