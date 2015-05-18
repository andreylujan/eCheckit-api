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
#  data                  :json
#

class ReportAction < ActiveRecord::Base
  belongs_to :report_action_type
  belongs_to :user
  belongs_to :report
end
