# == Schema Information
#
# Table name: report_fields
#
#  id                   :integer          not null, primary key
#  report_id            :integer
#  report_field_type_id :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  value                :json             not null
#  editable             :boolean          default(FALSE), not null
#

class ReportFieldSerializer < ActiveModel::Serializer
  attributes :id, :value, :report_field_name, :report_field_type_id, :editable
  def report_field_name
  	object.report_field_type.name
  end
end
