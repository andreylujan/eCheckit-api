class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.references :organization, index: true, foreign_key: true
      t.text :domain, null: false
      t.text :email, null: false
      t.boolean :allow_automatic_registration, null: false, default: true

      t.timestamps null: false
    end
    add_index :domains, [ :organization_id, :domain ], unique: true
    add_index :domains, :email, unique: true
  end
end
