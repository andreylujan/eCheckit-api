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
#

class ReportFieldSerializer < ActiveModel::Serializer
  attributes :id, :value
  has_one :report
  has_one :report_field_type
end
