# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :text             not null
#  last_name              :text
#  picture                :text
#  is_demo                :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  has_many :created_reports, foreign_key: :creator_id, class_name: :Report
  has_many :assigned_reports, foreign_key: :assigned_user_id, class_name: :Report
  has_many :actions
  has_many :feedbacks
  
  after_create :create_token
  after_create :assign_default_workspace
  after_create :check_organization
  validates_presence_of [ :first_name ]
  before_create :downcase_attributes
  has_many :workspace_invitations
  
  def create_token
    app = doorkeeper_app
    if not app
      app = Doorkeeper::Application.create name: "echeckit", redirect_uri: "https://127.0.0.1"
    end
    Doorkeeper::AccessToken.create resource_owner_id: self.id, application_id: app.id
  end

  def access_token
    access_tokens.last
  end
  
  def name
    name = first_name
    if last_name.present?
      name = name + " " + last_name
    end
    name
  end

  def access_tokens
    Doorkeeper::AccessToken.where(resource_owner_id: id)
  end

  def organizations
    orgs = {}
    works = self.workspaces
    pruned = [ "created_at", "updated_at", "organization_id" ]
    works.each do |w|
      org = w.organization
      if orgs[org.id].nil?
        orgs[org.id] = org.as_json.reject! { |k, v| pruned.include? k }
        orgs[org.id][:workspaces] = []
      end
      invitation = self.workspace_invitations.find_by_workspace_id w.id
      workspace_json = w.as_json.reject! { |k, v| pruned.include? k }
       if invitation.nil?
        workspace_json[:invited] = false
      else
        workspace_json[:invited] = true
        workspace_json[:accepted] = invitation.accepted?
      end
      orgs[org.id][:workspaces] << workspace_json
     
    end
    orgs.values
  end

  def accepted_invitation?(workspace)
    invitation = self.workspace_invitations.find_by_workspace_id workspace.id
    accepted = invitation.present? and invitation.accepted?
  end

  def workspaces
    workspaces = []
    roles.where(resource_type: "Workspace", name: "user").each do |r|  
      workspaces << r.resource 
    end
    workspaces
  end

  private

  def doorkeeper_app
  	@app ||= Doorkeeper::Application.find_by_name("echeckit")    
  end

  def downcase_attributes
    self.email.downcase!
  end

  def assign_default_workspace
    org = Organization.create name: "eCheckit"
    w = Workspace.create name: self.name, organization: org
    self.add_role :user, w
  end

  def check_organization
    idx = self.email.index("@") + 1
    email_domain = self.email[idx..-1]
    domain = Domain.find_by_domain(email_domain)
    if domain.present? and domain.allow_automatic_registration?
      org = domain.organization
      open_workspaces = org.workspaces.where(is_open: true)
      open_workspaces.each do |w|
        self.add_role :user, w
      end
    end
  end
end
