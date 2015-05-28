# == Schema Information
#
# Table name: report_action_types
#
#  id              :integer          not null, primary key
#  name            :text
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  formatted_name  :text
#

class ReportActionTypeSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :organization
end
