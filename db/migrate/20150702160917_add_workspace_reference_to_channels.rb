class AddWorkspaceReferenceToChannels < ActiveRecord::Migration
  def change
    add_reference :channels, :workspace, index: true, foreign_key: true
  end
end
