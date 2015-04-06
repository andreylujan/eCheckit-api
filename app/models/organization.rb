# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Organization < ActiveRecord::Base
	has_many :organization_users
	has_many :organizations, through: :organization_users
	has_many :users, through: :organization_users
	has_many :action_types, dependent: :nullify
    has_many :report_types, dependent: :nullify
    has_many :report_states, dependent: :nullify
    has_many :venues, dependent: :nullify
end
