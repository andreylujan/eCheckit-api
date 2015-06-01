class CreateZoneAssignments < ActiveRecord::Migration
  def change
    create_table :zone_assignments do |t|
      t.references :channel, index: true, foreign_key: true
      t.references :subchannel, index: true, foreign_key: true
      t.references :region, index: true, foreign_key: true
      t.references :commune, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
