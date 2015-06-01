class CreateContestPhrases < ActiveRecord::Migration
  def change
    create_table :contest_phrases do |t|
      t.references :organization, index: true, foreign_key: true
      t.integer :tier, null: false
      t.text :phrase, null: false

      t.timestamps null: false
    end
  end
end
