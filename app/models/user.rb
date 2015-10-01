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
  has_many :created_reports, foreign_key: :creator_id, class_name: :Report, dependent: :nullify
  has_many :assigned_reports, foreign_key: :assigned_user_id, class_name: :Report, dependent: :nullify
  has_many :report_actions, dependent: :nullify
  has_many :feedbacks
  
  after_create :create_token
  after_create :assign_default_workspace
  after_create :check_organization
  after_create :check_invitations
  after_create :send_welcome_email
  validates_presence_of [ :first_name ]
  before_create :downcase_attributes
  has_many :workspace_invitations, dependent: :destroy
  has_many :zone_managers, dependent: :destroy
  has_many :zone_assignments, through: :zone_managers
  has_many :devices, dependent: :destroy
  
  def create_token
    app = doorkeeper_app
    if not app
      app = Doorkeeper::Application.create name: "echeckit", redirect_uri: "https://127.0.0.1"
    end
    Doorkeeper::AccessToken.create resource_owner_id: self.id, application_id: app.id, scopes: :user
  end

  def access_token
    access_tokens.last
  end
  
  def clear_reset_token
    self.reset_password_token = nil
    self.reset_password_sent_at = nil
    save
  end

  def valid_reset_token?(token)
    valid = (self.reset_password_token.present? and 
      token == self.reset_password_token and 
      DateTime.now < reset_password_sent_at + 10.minutes)
  end

  def generate_reset_token
    token = ""
    4.times do |i|
      token = token + rand(10).to_s
    end
    self.reset_password_token = token
    self.reset_password_sent_at = DateTime.now
    save
  end


  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now!
  end

  def send_password_confirmation_token
    UserMailer.password_confirmation_token_email(self).deliver_now!
  end

  def admin_workspace_ids
    roles.where(name: "admin").pluck :resource_id
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
    pruned = [ :domains ]
    works.each do |w|
      org = w.organization
      if orgs[org.id].nil?
        orgs[org.id] = OrganizationSerializer.new(org).as_json.reject! { |k, v| pruned.include? k }
        orgs[org.id][:workspaces] = []
      end
      invitation = self.workspace_invitations.find_by_workspace_id w.id
      workspace_json = w.as_json.reject { |k, v| pruned.include? k }
      if invitation.present?
        workspace_json[:accepted] = invitation.accepted?
        orgs[org.id][:workspaces] << workspace_json
      end
      

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

  def check_invitations
    WorkspaceInvitation.where(user_email: "ejemplo3@koandina.cl").each do |invitation|
      invitation.udate_attribute :user_id, self.id
    end
  end

  def assign_default_workspace
    org = Organization.create name: "eCheckit"
    w = Workspace.create name: self.name, organization: org
    self.add_role :user, w
    WorkspaceInvitation.create user: self, workspace: w, accepted: true
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
