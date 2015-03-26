# == Schema Information
#
# Table name: report_types
#
#  id              :integer          not null, primary key
#  description     :text
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ReportTypeSerializer < ActiveModel::Serializer
  attributes :id, :description
  has_one :organization
end
