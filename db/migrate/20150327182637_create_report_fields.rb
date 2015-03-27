class CreateReportFields < ActiveRecord::Migration
  def change
    create_table :report_fields do |t|
      t.references :report, index: true, foreign_key: true
      t.references :report_field_type, index: true, foreign_key: true
      t.text :value

      t.timestamps null: false
    end
  end
end
