# == Schema Information
#
# Table name: report_types
#
#  id              :integer          not null, primary key
#  description     :text
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ReportType < ActiveRecord::Base
  belongs_to :organization
  has_many :reports
end
