class CreateReportFieldTypes < ActiveRecord::Migration
  def change
    create_table :report_field_types do |t|
      t.text :description
      t.references :report_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
