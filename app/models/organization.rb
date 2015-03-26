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
	has_many :users
	has_many :action_types
    has_many :report_types
    has_many :report_states
    has_many :venues
end
