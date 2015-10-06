class AddImageToChecklists < ActiveRecord::Migration
  def change
    add_column :checklists, :image, :text
  end
end
