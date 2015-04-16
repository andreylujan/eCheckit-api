class AddCommentToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :comment, :text
  end
end
