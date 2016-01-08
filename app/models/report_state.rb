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

class ReportState < ActiveRecord::Base
  belongs_to :workspace
  has_many :reports
  has_many :report_actions
  validates_uniqueness_of [ :name ], scope: :workspace_id
end
