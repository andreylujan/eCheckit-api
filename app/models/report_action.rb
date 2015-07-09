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
#  data                  :json             default({}), not null
#  report_state_id       :integer
#

class ReportAction < ActiveRecord::Base
  belongs_to :report_action_type
  belongs_to :user
  belongs_to :report
  after_create :perform_action
  validates_presence_of [ :report, :user, :report_action_type, :data ]
  validate :data_attributes_present
  belongs_to :report_state
  before_create :check_report_state
  

  def data_attributes_present
    if self.report_action_type.name == "assign"
      if data.present?
        if data["assigned_user_id"].nil?
          errors.add(:data, "assigned_user_id must be present in data object")
        elsif not data["assigned_user_id"].is_a? Integer
          errors.add(:data, "assigned_user_id must be an integer")
        else
          assigned_user = User.find_by_id(data["assigned_user_id"])
          if assigned_user.nil?
            errors.add(:data, "No user matches id #{data['assigned_user_id']}")
          else
            data["assigned_user_name"] = assigned_user.name
          end
        end
      end
    else
      if data.present?
        assigned_user = self.report.assigned_user
        if assigned_user.present?
          data["assigned_user_name"] = assigned_user.name
          data["assigned_user_id"] = assigned_user.id
        end
      end
    end
  end

  def send_create_email
    if self.report.workspace.organization.name == "Koandina"

      message = ""
      emails = []
      if self.report_action_type.name == "assign"
        if self.report.assign_actions.count > 1
          emails << {
            destinatary: self.report.assigned_user.email,
            message: "Un reporte que fue originalmente asignado a usted ha sido reasignado",
            user_name: self.report.assigned_user.name
          }
        end
        first_assigned_user_id = self.report.report_actions.first.data["assigned_user_id"]
        first_assigned_user = User.find(first_assigned_user_id)
        emails << {
          destinatary: first_assigned_user.email,
          message: "Un reporte que fue originalmente asignado a usted ha sido reasignado",
          user_name: first_assigned_user.name
        }
      elsif self.report_action_type.name == "change_state" and 
        self.report_state.name == "Cerrado"
        self.report.assign_actions.each do |action|
          assigned_user_id = action.data["assigned_user_id"]
          assigned_user = User.find(assigned_user_id)
          emails << {
            destinatary:  assigned_user.email,
            message: "Un reporte al cual fue asignado ha sido cerrado",
            user_name: assigned_user.name
          }
        end
      end
      emails.uniq! { |e| e[:destinatary] }
      gmail = Gmail.connect ENV["EWIN_EMAIL"], ENV["EWIN_PASSWORD"]
      emails.each do |email|
        
        f = File.open('./templates/reports/create.html.erb')
        template = f.read
        f.close
        params = {
          workspace_name: self.report.workspace.name,
          user_name: email[:user_name],
          pdf: self.report.pdf,
          message: email[:message]
        }


        html = Erubis::Eruby.new(template).result params
        f = File.open('./templates/reports/create.txt.erb')
        template = f.read
        f.close
        text = Erubis::Eruby.new(template).result params

        gmail.deliver! do
          to email[:destinatary]
          subject "Se le ha asignado un reporte"
          text_part do
            body text
          end
          html_part do
            content_type 'text/html; charset=UTF-8'
            body html
          end
        end
      end
      
    end
  end
  
  private

  def check_report_state
    if self.report_state.nil?
      self.report_state = self.report.report_state
    end
  end

  def perform_action
    if self.report_action_type.name == "assign"
      self.report.update_attribute :assigned_user_id, self.data["assigned_user_id"]
    end
    self.report.update_attribute :report_state_id, self.report_state_id
  end

  
  
end
