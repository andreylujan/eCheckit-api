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
  
  after_create :create_default_states

  def users
    workspace_users = User.joins(:workspace_invitations).where("workspace_invitations.accepted = true and workspace_id = ?", self.id)
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
    end
    json
  end

  private
  def create_default_states
  	ReportState.create workspace: self, name: "Creado"
	ReportState.create workspace: self, name: "Asignado"
  end
end
