class ZoneAssignmentSerializer < ActiveModel::Serializer
  attributes :id
  has_one :channel
  has_one :subchannel
  has_one :region
  has_one :commune
end
