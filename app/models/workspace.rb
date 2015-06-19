# == Schema Information
#
# Table name: workspaces
#
#  id              :integer          not null, primary key
#  name            :text
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  is_open         :boolean          default(TRUE), not null
#

class Workspace < ActiveRecord::Base
  include ActiveModel::Serialization
  resourcify
  belongs_to :organization
  has_many :reports
  has_many :report_field_types
  has_many :report_states, dependent: :nullify
  has_many :workspace_invitations
  has_many :zone_assignments
  has_many :contests
  
  after_create :create_default_states
  
  def report_counts
    contest = self.contests.last
    if contest.present?
      reports = self.reports.where("created_at > ? and created_at < ?", contest.starts_at, contest.ends_at)
      counts = reports.group(:creator_id).count
      counts_arr = []
      counts.each do |k, v|
        counts_arr << {
          user_id: k,
          num_reports: v
        }
        
      end

      if counts_arr.length == 0
        counts_arr << {
          user_id: -1,
          num_reports: 1
        }
      end
      return counts_arr
    end
  end

  def local_dashboard(reports)
    reason_counts = {}
    reports_count = reports.count
    reports.each do |report|
      report.report_fields.each do |report_field|
        if report_field.report_field_type_id == 1
          if report_field.value.present? and report_field.value["title"].present?
            reason_counts[report_field.value["title"]] ||= 0
            reason_counts[report_field.value["title"]] += 1
          end 
        end
      end
    end
    return {
      reports_count: reports_count,
      reason_counts: reason_counts
    }
  end

  def dashboard
    if self.organization_id == 1
      reports = self.reports
      global_info = local_dashboard(reports)
      regions = []
      Region.all.each do |region|
        region_reports = reports.where("lower(unaccent(region)) = ?", I18n.transliterate(region.name).downcase)
        local_info = local_dashboard(region_reports)
        local_info[:region_id] = region.id
        regions << local_info
      end
      global_info[:regions] = regions
      return global_info
    end
  end

  def current_contest
    active_contest = self.contests.where("starts_at < ? and ends_at > ?", DateTime.now, DateTime.now).last
    if active_contest
      ContestSerializer.new(active_contest).as_json
    end
  end

  def user_ids    
    invitations = self.workspace_invitations.where(accepted: true)
    invitations.pluck(:user_id)
  end

  def users
    workspace_users = User.joins(:workspace_invitations).where("workspace_id = ?", self.id).order(:id)
    maps = workspace_users.map do |u|
      WorkspaceUserSerializer.new u
    end

    

    json = maps.as_json

    json.each do |u|
      invitation = WorkspaceInvitation.find_by_user_id_and_workspace_id u[:id], self.id
      if invitation.present? and invitation.accepted?
        u[:accepted] = true
        u[:pending] = false
      else
        u[:pending] = true
        u[:accepted] = false
      end
      if workspace_users.find_by_id(u[:id]).has_role? :admin, self
        u[:is_admin] = true
      else
        u[:is_admin] = false
      end
      u[:is_registered] = true
    end
    WorkspaceInvitation.where(user: nil, workspace: self).each do |unregistered|
      json << {
        email: unregistered.user_email,
        is_registered: false
      }
    end

    json
  end

  private
  def create_default_states
  	ReportState.create workspace: self, name: "Creado"
   ReportState.create workspace: self, name: "Asignado"
 end
end
