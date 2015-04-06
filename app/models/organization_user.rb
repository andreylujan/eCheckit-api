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

class OrganizationUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
end
