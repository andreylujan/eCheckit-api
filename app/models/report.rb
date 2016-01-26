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
#  title            :text             not null
#  address          :text
#  city             :text
#  region           :text
#  commune          :text
#  country          :text
#  longitude        :float            default(0.0)
#  latitude         :float            default(0.0)
#  reference        :text
#  comment          :text
#  pdf              :text
#  reason_id        :integer
#  channel_id       :integer
#  subchannel_id    :integer
#  internal_id      :text             not null
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
    belongs_to :channel
    belongs_to :subchannel
    belongs_to :reason
    after_destroy :delete_pdf
    before_create :validate_geolocation

    validates_uniqueness_of :internal_id
    validates_presence_of [ :workspace, :creator, 
    	:title  ]
    	
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

        def validate_geolocation
            if self.latitude.nil?
                self.latitude = 0
            end
            if self.longitude.nil?
                self.longitude = 0
            end
        end

        def assign_actions
            report_actions.joins(:report_action_type).where("report_action_types.name = ?", "assign")
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

        def escaped_attributes
            attrs = self.attributes.values
            attrs.map do |a| 
                if a.nil?
                    a
                elsif a == ""
                    nil
                else
                    a.to_s.gsub(/\n/, ' ')
                end
            end
        end

        def assign_reason
            reason_field = self.report_fields.where(report_field_type_id: 1).first
            if reason_field
                reason_name = reason_field.value["title"]
                if reason_name.present?
                    reason = Reason.find_by_workspace_id_and_name(
                        self.workspace_id, reason_name)
                    if reason.present?
                        self.update_attribute :reason, reason
                    end
                end
            end
        end

        def generate_assign_action
            if self.workspace.organization.name == "Koandina"
                assign_action_type = self.workspace.organization.report_action_types.where(name: "assign").first
                if assign_action_type
                    action = ReportAction.create report_action_type: assign_action_type, user: self.creator,
                    report: self, data: {
                        assigned_user_id: self.assigned_user.id,
                        comment: "Asignación automática",
                        assigned_user_name: self.assigned_user.name,
                        report_state_id: self.report_state_id
                    }
                   
                end
            end
        end

        def perform_assignment(assignment)
            # Assign default
            if assignment.nil?
                if self.workspace.organization_id == 1
                    self.update_attribute :assigned_user_id, 220
                    generate_assign_action
                end
            else
                managers = assignment.managers
                if managers.count == 1                   
                    self.update_attribute :assigned_user, managers.first
                    generate_assign_action
                elsif self.workspace.organization_id == 1
                    self.update_attribute :assigned_user_id, 220
                    generate_assign_action                    
                end                
            end
        end

        def assign_user
            channel_field = self.report_fields.where(report_field_type_id: 2).first
            action_type = self.assign_action_type
         
            if channel_field
                channel = channel_field.value["title"]
                subitem = channel_field.value["subitem"]

                if channel.present?
                    channel = Channel.find_by_workspace_id_and_name(
                        self.workspace_id, channel)
                    region = nil
                    commune = nil
                    subchannel = nil
                    if channel.present?
                        self.update_attribute :channel, channel
                        if subitem.present?
                            subchannel = Subchannel.find_by_channel_id_and_name(
                                channel.id, subitem)
                            if subchannel.present?
                                self.update_attribute :subchannel, subchannel
                            end
                        end

                        region = Region.find_by_name self.region
                        if region.present?
                            commune = Commune.find_by_name self.commune
                        end

                        assignments = ZoneAssignment.where(workspace_id: self.workspace_id)

                        
                        channel_id = channel ? channel.id : nil
                        subchannel_id = subchannel ? subchannel.id : nil
                        region_id = region ? region.id : nil
                        commune_id = commune ? commune.id : nil

                        

                        # Channels
                        channel_assignments = assignments.where(channel: channel)
                        if channel_assignments.count == 0
                            channel_assignments = assignments.where(channel_id: nil)
                        end

                        # Subchannels
                        subchannel_assignments = channel_assignments.where(
                            subchannel: subchannel
                        )
                        if subchannel_assignments.count == 0
                            subchannel_assignments = channel_assignments.where(subchannel_id: nil)
                        end

                        # Regions
                        region_assignments = subchannel_assignments.where(region: region)
                        if region_assignments.count == 0
                            region_assignments = subchannel_assignments.where(region_id: nil)
                        end

                        # Communes
                        commune_assignments = region_assignments.where(commune: commune)
                        if commune_assignments.count == 0
                            commune_assignments = region_assignments.where(commune_id: nil)
                        end

                        perform_assignment(commune_assignments.first)   
                    end
                end
            end
        end
    end
