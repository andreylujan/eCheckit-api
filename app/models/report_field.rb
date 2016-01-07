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
#  editable             :boolean          default(FALSE), not null
#

class ReportField < ActiveRecord::Base
  belongs_to :report
  belongs_to :report_field_type

  before_save :process_contact

  private

  def process_contact
    if self.report_field_type_id == 22 and self.value.present? and self.value["id"].nil?        
        work_field = self.report.report_fields.find_by_report_field_type_id(16)
        construction_id = nil
        if work_field
            construction_id = work_field.value["works_id"] ? work_field.value["works_id"] : work_field.value["construction_id"]
        end
        self.value["email"] = self.value["email"].downcase

        contact = Contact.find_by_email(self.value["email"])
        if contact.nil?
            contact = Contact.new email: self.value["email"],
                name: self.value["name"],
                phone: self.value["phone"],
                construction_id: construction_id      
            contact.save
        end
        self.value["id"] = contact.id
    elsif self.report_field_type_id == 16
        contact_field = self.report.report_fields.find_by_report_field_type_id(22)
        if not contact_field.nil?
            contact_id = contact_field.value["id"]
            contact = Contact.find(contact_id)
            if contact.construction_id.nil?
                construction_id = self.value["works_id"] || self.value["construction_id"]
                contact.update_attribute :construction_id, construction_id
            end
        end
    end
  end

end
