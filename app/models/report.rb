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
#  start_date       :datetime
#  finish_date      :datetime
#  finish_latitude  :float
#  finish_longitude :float
#  visit_date       :datetime
#  start_latitude   :float
#  start_longitude  :float
#

class Report < ActiveRecord::Base

  belongs_to :creator, foreign_key: :creator_id, class_name: :User
  belongs_to :assigned_user, foreign_key: :assigned_user_id, class_name: :User
  has_many :report_actions, dependent: :destroy
  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures
  has_many :report_fields, dependent: :destroy
  accepts_nested_attributes_for :report_fields
  acts_as_paranoid
  belongs_to :report_state
  belongs_to :workspace
  belongs_to :channel
  belongs_to :subchannel
  belongs_to :reason
  after_destroy :delete_pdf
  before_create :validate_geolocation
  validate :max_pictures
  validates_uniqueness_of :internal_id
  validates_presence_of [ :workspace, :creator,
                          :title  ]

  before_create :verify_state
  before_create :verify_assigned_user
  after_create :assign_user
  after_create :assign_reason
  after_create :verify_checklists

  def verify_assigned_user
    if self.assigned_user_id.nil? and self.creator_id.present?
      self.assigned_user_id = self.creator_id
    end
  end

  def verify_checklists
    destroyed_fields = []
    self.report_fields.each do |field|
      if field.report_field_type.name == "checklist"
        categories = field.value["checklist_categories"]
        total_sum = 0
        categories.each do |category|
          category_sum = category["checklist_items"].inject(0) { | sum, el | sum + el["value"] }
          total_sum = total_sum + category_sum
        end
        if total_sum == 0
          destroyed_fields << field
        end
      end
    end
    destroyed_fields.each do |field|
      field.destroy
    end
  end

  def max_pictures
    max_pictures = 50
    if self.pictures.length > max_pictures
        errors.add(:pictures, "El número máximo de fotos es #{max_pictures}")
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
      self.report_state = self.workspace.default_report_state
    end
  end

  def delete_pdf
    if Rails.env.production? and self.pdf.present?
      pdf_key = pdf[pdf.rindex(/\//) + 1..pdf.length - 1]
      begin
        Amazon.delete_object(pdf_key)
      rescue Exception => e
        Rails.logger.error('Could not delete pdf ' + pdf_key)
      end
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


          channel_assignments = ZoneAssignment.where(
          channel: channel)
          assignments = channel_assignments
          subchannel_assignments = channel_assignments.where(
            subchannel: subchannel
          )
          if subchannel_assignments.count > 0
            assignments = subchannel_assignments
          end
          region_assignments = assignments.where(
          region: region)
          assignments = region_assignments
          commune_assignments = assignments.where(commune:
                                                  commune)
          assignments = commune_assignments
          assignment = assignments.first
          if assignment.present?
            managers = assignment.managers
            if managers.count == 1
              self.update_attribute :assigned_user, managers.first
            else
              self.update_attribute :assigned_user_id, 28
            end
            generate_assign_action
          elsif self.workspace.organization_id == 1
            self.update_attribute :assigned_user_id, 28
            generate_assign_action
          end
        end
      end
    end
    # if self.assigned_user.nil? and self.workspace.organization_id == 1
    #    self.update_attribute :assigned_user_id, 28
    #    generate_assign_action
    # end
  end
end
