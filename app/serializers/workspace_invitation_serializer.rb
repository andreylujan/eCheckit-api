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

class WorkspaceInvitationSerializer < ActiveModel::Serializer
  attributes :id, :workspace_id, :user_id, :user_email, :accepted, :confirmation_token
end
