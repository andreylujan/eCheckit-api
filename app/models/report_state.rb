# == Schema Information
#
# Table name: report_states
#
#  id              :integer          not null, primary key
#  description     :text
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ReportState < ActiveRecord::Base
  belongs_to :workspace
  has_many :reports
end
