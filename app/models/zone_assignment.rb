class ZoneAssignment < ActiveRecord::Base
  belongs_to :channel
  belongs_to :subchannel
  belongs_to :region
  belongs_to :commune
  has_many :zone_managers, dependent: :destroy
  has_many :managers, through: :zone_managers, source: :user
  validates_uniqueness_of [ :commune ], scope: [ :channel, :subchannel, :region ] 
end
