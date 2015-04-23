class AddRatingToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :rating, :integer, null: false
    add_index :feedbacks, :rating, unique: false
  end
end
