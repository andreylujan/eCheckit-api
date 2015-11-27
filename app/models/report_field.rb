# == Schema Information
#
# Table name: report_fields
#
#  id                   :integer          not null, primary key
#  report_id            :integer
#  report_field_type_id :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  value                :json             not null
#

class ReportField < ActiveRecord::Base
  belongs_to :report
  belongs_to :report_field_type

  after_create :process_contact

  private

  def process_contact
    if self.report_field_type_id == 22 and self.value.present? and self.value["id"].nil?
        # contact = ContactDom.new work_id: 
    end
  end

end
