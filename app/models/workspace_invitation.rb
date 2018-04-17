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
  before_validation :lowercase_email
  # before_save :add_user
  after_create :send_email
  after_create :add_user_role
  before_save :verify_user
  after_save :check_accepted

  def send_email
    if not self.accepted?
      UserSendGridMailer.invite_email(self)
    end
  end

  def regenerate_token
  	self.confirmation_token = SecureRandom.urlsafe_base64(64)
    send_email
    self.save
  end

  private

  def add_user_role
    if self.user.present?
      self.user.add_role :user, self.workspace
    end
  end

  def lowercase_email
    self.user_email = self.user_email.downcase if self.user_email.present?
  end

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
