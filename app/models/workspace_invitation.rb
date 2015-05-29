# == Schema Information
#
# Table name: workspace_invitations
#
#  id                 :integer          not null, primary key
#  workspace_id       :integer          not null
#  user_id            :integer
#  accepted           :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  confirmation_token :text             not null
#  user_email         :text             not null
#

class WorkspaceInvitation < ActiveRecord::Base
  belongs_to :workspace
  belongs_to :user

  validates_presence_of [ :workspace, :user_email ]
  validates_uniqueness_of :user_email, scope: :workspace

  before_create :generate_confirmation_token
  before_create :verify_user
  # before_save :add_user
  after_create :send_email
  after_save :check_accepted

  def send_email
    gmail = Gmail.connect ENV["EWIN_EMAIL"], ENV["EWIN_PASSWORD"]
    url = ""
    user_email = self.user_email
    token = self.confirmation_token
    gmail.deliver! do
      to user_email
      subject "Confirme su usuario eCheckit"
      text_part do
        body 'Bienvenido a eCheckit! Para confirmar su correo, por favor haga ingrese a http://52.0.24.103/#/core/signup' +
        '?confirmation_token=' + token
      end
      html_part do
        content_type 'text/html; charset=UTF-8'
        body 'Bienvenido a eCheckit! Para confirmar su correo, por favor haga click <a href="http://52.0.24.103/#/core/signup' +
        '?confirmation_token=' + token + '">aquí</a>'
      end
    end
  end

  def regenerate_token
  	self.confirmation_token = SecureRandom.urlsafe_base64(64)
    send_email
  	self.save
  end

  private

  def verify_user
    if self.user_email.present?
      self.user = User.find_by_email(self.user_email)
    end
  end

  def check_accepted
    if self.accepted_changed?
      add_user
    end
  end

  def generate_confirmation_token
  	self.confirmation_token = SecureRandom.urlsafe_base64(64)
  end

  def add_user
    u = User.find_by_id(self.user_id)
    w = Workspace.find_by_id(self.workspace_id)
    if u.present? and w.present?
      u.add_role :user, w
    end
  end
end

