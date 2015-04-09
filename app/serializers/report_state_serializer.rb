# == Schema Information
#
# Table name: report_states
#
#  id           :integer          not null, primary key
#  description  :text
#  workspace_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ReportStateSerializer < ActiveModel::Serializer
  attributes :id, :description
  has_one :organization
end
