class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.references :action_type, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :report, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
