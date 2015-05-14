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

  after_create :create_default_states

  private
  def create_default_states
  	ReportState.create workspace: self, name: "Creado"
	ReportState.create workspace: self, name: "Asignado"
  end
end
