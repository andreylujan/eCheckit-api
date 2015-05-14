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

require 'rails_helper'

RSpec.describe WorkspaceInvitation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
