# == Schema Information
#
# Table name: actions
#
#  id             :integer          not null, primary key
#  action_type_id :integer
#  user_id        :integer
#  report_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ActionSerializer < ActiveModel::Serializer
  attributes :id
  has_one :action_type
  has_one :user
  has_one :report
end
