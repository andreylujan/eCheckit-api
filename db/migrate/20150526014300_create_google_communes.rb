class CreateGoogleCommunes < ActiveRecord::Migration
  def change
    create_table :google_communes do |t|
      t.text :commune
      t.text :google_commune

      t.timestamps null: false
    end
  end
end
