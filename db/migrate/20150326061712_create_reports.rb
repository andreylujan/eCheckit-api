class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :creator_id, null: false
      t.integer :assigned_user_id

      t.timestamps null: false
    end
  end
end
