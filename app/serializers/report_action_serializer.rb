# == Schema Information
#
# Table name: report_actions
#
#  id                    :integer          not null, primary key
#  report_action_type_id :integer
#  user_id               :integer
#  report_id             :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  data                  :json             default({}), not null
#  report_state_id       :integer
#

class ReportActionSerializer < ActiveModel::Serializer
  attributes :id, :report_action_type_id, :user_id, :report_id, :created_at, :updated_at,
  :data, :report_action_type_name, :report_state_id

  def report_action_type_name
  	object.report_action_type.name
  end

end
