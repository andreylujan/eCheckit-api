class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.references :workspace, index: true, foreign_key: true
      t.datetime :starts_at
      t.datetime :ends_at
      t.text :prize
      t.float :tiers, array: true, null: false, default: [ 0.33, 0.66 ]

      t.timestamps null: false
    end
  end
end
