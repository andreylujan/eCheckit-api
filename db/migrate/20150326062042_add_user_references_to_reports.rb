class AddUserReferencesToReports < ActiveRecord::Migration
  def change
  	add_index :reports, :creator_id, unique: false
  	add_index :reports, :assigned_user_id, unique: false
  	add_foreign_key :reports, :users, column: :creator_id
  	add_foreign_key :reports, :users, column: :assigned_user_id
  end
end
