# == Schema Information
#
# Table name: reports
#
#  id               :integer          not null, primary key
#  creator_id       :integer          not null
#  assigned_user_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  report_state_id  :integer
#  workspace_id     :integer
#  venue_id         :integer
#  title            :text             not null
#  address          :text
#  city             :text
#  region           :text
#  commune          :text
#  country          :text
#  longitude        :float            not null
#  latitude         :float            not null
#  reference        :text
#  comment          :text
#

class Report < ActiveRecord::Base

	belongs_to :creator, foreign_key: :creator_id, class_name: :User
	belongs_to :assigned_user, foreign_key: :assigned_user_id, class_name: :User
    has_many :report_actions
    has_many :pictures, dependent: :destroy
    accepts_nested_attributes_for :pictures
    has_many :report_fields
    accepts_nested_attributes_for :report_fields
    belongs_to :report_state
    belongs_to :workspace
    belongs_to :venue
    

    validates_presence_of [ :workspace, :creator, 
    	:title, :longitude, :latitude ]
    	
    before_create :verify_state
    after_create :assign_user

    def assigned_at
        assigned_action_type = ReportActionType.find_by_organization_id_and_name(
            self.workspace.organization_id, "assign")
        if assigned_action_type
            last_assign = self.report_actions.where(report_action_type_id: assigned_action_type.id).last
            if last_assign
                last_assign.created_at
            end
        end
    end

    def assign_action_type
        ReportActionType.find_by_organization_id_and_name(
            self.workspace.organization_id, "assign")
    end

    def assigned_user_name
        if assigned_user.present?
            assigned_user.name
        end
    end

    private
    def verify_state
        if report_state.nil?
            self.report_state = ReportState.find_by_workspace_id_and_name self.workspace_id, "Creado"
        end
    end

    def assign_user
        channel_field = self.report_fields.where(report_field_type_id: 2).first
        action_type = self.assign_action_type


        if channel_field
            channel = channel_field.value["title"].downcase
            subitem = channel_field.value["subitem"].downcase
            if channel.present? and subitem.present?
                channel = Channel.find_by_organization_id_and_name(
                    self.workspace.organization_id, channel)
                if channel.present?
                    subchannel = Subchannel.find_by_channel_id_and_name(
                    channel.id, subitem)
                    if subchannel.present?
                        
                        r = ReportAction.create report_action_type: action_type,
                        report_id: self.id, report_state_id: self.report_state_id,
                        data: {
                            assigned_user_id: subchannel.direct_manager_id,
                            comment: "",
                            assigned_user_name: subchannel.direct_manager.name
                        }, 
                        user: self.creator
                    end
                end
            end
        end
    end
end
