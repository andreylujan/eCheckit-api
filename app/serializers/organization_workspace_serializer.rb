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

class OrganizationWorkspaceSerializer < ActiveModel::Serializer
  attributes :id, :name
end
