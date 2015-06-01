class CreateZoneManagers < ActiveRecord::Migration
  def change
    create_table :zone_managers do |t|
      t.references :zone_assignment, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
