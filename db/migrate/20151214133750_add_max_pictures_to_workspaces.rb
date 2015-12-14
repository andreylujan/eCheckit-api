class AddMaxPicturesToWorkspaces < ActiveRecord::Migration
  def change
    add_column :workspaces, :max_pictures, :integer, null: false, default: 20
  end
end
