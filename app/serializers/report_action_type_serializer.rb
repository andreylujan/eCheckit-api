# == Schema Information
#
# Table name: report_action_types
#
#  id              :integer          not null, primary key
#  description     :text
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ReportActionTypeSerializer < ActiveModel::Serializer
  attributes :id, :description
  has_one :organization
end
