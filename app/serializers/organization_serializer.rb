# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :domains
end
