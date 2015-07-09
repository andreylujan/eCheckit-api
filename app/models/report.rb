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
#  pdf              :text
#  reason_id        :integer
#  channel_id       :integer
#  subchannel_id    :integer
#

class Report < ActiveRecord::Base

	belongs_to :creator, foreign_key: :creator_id, class_name: :User
	belongs_to :assigned_user, foreign_key: :assigned_user_id, class_name: :User
    has_many :report_actions, dependent: :destroy
    has_many :pictures, dependent: :destroy
    accepts_nested_attributes_for :pictures
    has_many :report_fields, dependent: :destroy
    accepts_nested_attributes_for :report_fields
    belongs_to :report_state
    belongs_to :workspace
    belongs_to :venue
    belongs_to :channel
    belongs_to :subchannel
    belongs_to :reason
    after_destroy :delete_pdf

    validates_presence_of [ :workspace, :creator, 
    	:title, :longitude, :latitude ]
    	
        before_create :verify_state
        after_create :assign_user
        after_create :assign_reason

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

        def creator_name
            if creator.present?
                creator.name
            end
        end


        private
        def verify_state
            if report_state.nil?
                self.report_state = ReportState.find_by_workspace_id_and_name self.workspace_id, "Asignado"
            end
        end

        def delete_pdf
            if Rails.env.production? and self.pdf.present?
                pdf_key = pdf[pdf.rindex(/\//) + 1..pdf.length - 1]
                Amazon.delete_object(pdf_key)
            end
        end

        def assign_reason
            reason_field = self.report_fields.where(report_field_type_id: 1).first
            if reason_field
                reason_name = reason_field.value["name"]
                if reason_name.present?
                    reason = Reason.find_by_workspace_id_and_name(
                        self.workspace_id, reason_name)
                    if reason.present?
                        self.update_attribute :reason, reason
                    end
                end
            end
        end

        def assign_user
            channel_field = self.report_fields.where(report_field_type_id: 2).first
            action_type = self.assign_action_type


            if channel_field
                channel = channel_field.value["name"]
                subitem = channel_field.value["subitem"]
               
                if channel.present?
                    channel = Channel.find_by_workspace_id_and_name(
                        self.workspace_id, channel)
                    if channel.present?
                        self.update_attribute :channel, channel
                        if subitem.present?
                            subchannel = Subchannel.find_by_channel_id_and_name(
                                channel.id, subitem)
                            if subchannel.present?
                                self.update_attribute :subchannel, subchannel
                                region = Region.find_by_name self.region
                                if region.present?
                                    commune = Commune.find_by_name self.commune
                                    if commune.present?
                                        assignment = ZoneAssignment.where(
                                            channel: channel,
                                            subchannel: subchannel,
                                            region: region,
                                            commune: commune
                                            ).first
                                        if assignment.present?
                                            managers = assignment.managers
                                            if managers.count == 1
                                                self.update_attribute :assigned_user, managers.first
                                            else
                                                self.update_attribute :assigned_user_id, 28
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if self.assigned_user.nil? and self.workspace.organization_id == 1
                self.update_attribute :assigned_user_id, 28
            end
        end
    end
