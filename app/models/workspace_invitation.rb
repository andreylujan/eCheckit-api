# == Schema Information
#
# Table name: workspace_invitations
#
#  id                 :integer          not null, primary key
#  workspace_id       :integer          not null
#  user_id            :integer          not null
#  accepted           :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  confirmation_token :text             not null
#

class WorkspaceInvitation < ActiveRecord::Base
  belongs_to :workspace
  belongs_to :user

  validates_presence_of [ :workspace, :user ]
  validates_uniqueness_of :workspace_id, scope: :user

  before_create :generate_confirmation_token
  before_save :add_user

  def regenerate_token
  	self.confirmation_token = SecureRandom.urlsafe_base64(64)
  	self.save
  end

  private
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

