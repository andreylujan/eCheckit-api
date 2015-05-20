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

class ReportActionType < ActiveRecord::Base
  belongs_to :organization
  has_many :report_actions

  validates_presence_of [ :organization ]
end
