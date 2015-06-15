# == Schema Information
#
# Table name: report_field_types
#
#  id           :integer          not null, primary key
#  name         :text
#  workspace_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  widget_id    :integer
#  translations :json
#  data         :json
#  index        :integer
#

class ReportFieldTypeSerializer < ActiveModel::Serializer
  attributes :id, :name, :widget_name, :translations, :data
  
  def widget_name
  	object.widget.name
  end
end
