class AddTranslationsToReportFieldTypes < ActiveRecord::Migration
  def change
    add_column :report_field_types, :translations, :json
  end
end
