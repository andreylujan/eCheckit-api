# == Schema Information
#
# Table name: action_types
#
#  id              :integer          not null, primary key
#  description     :text
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ActionType < ActiveRecord::Base
  belongs_to :organization
  has_many :actions
end
