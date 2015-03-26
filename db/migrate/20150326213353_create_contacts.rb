class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.text :description
      t.text :phone_number
      t.references :venue, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
