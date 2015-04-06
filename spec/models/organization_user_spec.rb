# == Schema Information
#
# Table name: organization_users
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe OrganizationUser, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
