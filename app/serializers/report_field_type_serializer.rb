# == Schema Information
#
# Table name: report_field_types
#
#  id             :integer          not null, primary key
#  description    :text
#  report_type_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ReportFieldTypeSerializer < ActiveModel::Serializer
  attributes :id, :description
  has_one :report_type
end
