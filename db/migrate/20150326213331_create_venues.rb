class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.references :organization, index: true, foreign_key: true
      t.text :description

      t.timestamps null: false
    end
  end
end
