# == Schema Information
#
# Table name: workspace_invitations
#
#  id           :integer          not null, primary key
#  workspace_id :integer          not null
#  user_id      :integer          not null
#  accepted     :boolean          default(FALSE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class WorkspaceInvitation < ActiveRecord::Base
  belongs_to :workspace
  belongs_to :user

  validates_presence_of [ :workspace, :user ]
  validates_uniqueness_of :workspace_id, scope: :user
end
