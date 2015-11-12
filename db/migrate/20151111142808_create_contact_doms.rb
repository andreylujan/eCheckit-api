class CreateContactDoms < ActiveRecord::Migration
  def change
    create_table :contact_doms do |t|
      t.integer :work_id
      t.text :name
      t.text :email
      t.text :phone

      t.timestamps null: false
    end
  end
end
