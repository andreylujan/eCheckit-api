# == Schema Information
#
# Table name: venues
#
#  id              :integer          not null, primary key
#  organization_id :integer
#  description     :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class VenueSerializer < ActiveModel::Serializer
  attributes :id, :description
  has_one :organization
end
