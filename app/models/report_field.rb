# == Schema Information
#
# Table name: report_fields
#
#  id                   :integer          not null, primary key
#  report_id            :integer
#  report_field_type_id :integer
#  value                :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class ReportField < ActiveRecord::Base
  belongs_to :report
  belongs_to :report_field_type
end
