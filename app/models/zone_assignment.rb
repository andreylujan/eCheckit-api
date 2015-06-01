class ZoneAssignment < ActiveRecord::Base
  belongs_to :channel
  belongs_to :subchannel
  belongs_to :region
  belongs_to :commune
  has_many :zone_managers
  has_many :managers, through: :zone_managers, source: :user 
end
