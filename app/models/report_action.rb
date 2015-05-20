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
