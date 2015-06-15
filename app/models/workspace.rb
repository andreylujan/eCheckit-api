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
      reports = Report.where("created_at > ? and created_at < ?", contest.starts_at, contest.ends_at)
      counts = reports.group(:creator_id).count
      counts_arr = []
      counts.each do |k, v|
        counts_arr << {
          user_id: k,
          num_reports: v
        }
        
      end
      return counts_arr
    end
  end

  def current_contest
    active_contest = Contest.where("starts_at < ? and ends_at > ?", DateTime.now, DateTime.now).first
    if active_contest
      ContestSerializer.new(active_contest).as_json
    end
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
