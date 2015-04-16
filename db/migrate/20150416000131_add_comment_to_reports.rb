class AddCommentToReports < ActiveRecord::Migration
  def change
    add_column :reports, :comment, :text
  end
end
