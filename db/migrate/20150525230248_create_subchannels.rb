class CreateSubchannels < ActiveRecord::Migration
  def change
    create_table :subchannels do |t|
      t.references :channel, index: true, foreign_key: true
      t.text :name
      t.integer :direct_manager_id
      t.integer :indirect_manager_id

      t.timestamps null: false
    end
    add_index :subchannels, :direct_manager_id, unique: false
    add_index :subchannels, :indirect_manager_id, unique: false
  end
end
