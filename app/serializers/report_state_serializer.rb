# == Schema Information
#
# Table name: report_states
#
#  id           :integer          not null, primary key
#  name         :text             not null
#  workspace_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  short_name   :text
#  editable     :boolean          default(FALSE), not null
#

class ReportStateSerializer < ActiveModel::Serializer
  attributes :id, :name, :short_name, :editable
end
