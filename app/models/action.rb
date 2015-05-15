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
#  data           :json
#

class Action < ActiveRecord::Base
  belongs_to :action_type
  belongs_to :user
  belongs_to :report
end
