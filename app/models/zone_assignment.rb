# == Schema Information
#
# Table name: zone_assignments
#
#  id            :integer          not null, primary key
#  channel_id    :integer
#  subchannel_id :integer
#  region_id     :integer
#  commune_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  workspace_id  :integer          not null
#

class ZoneAssignment < ActiveRecord::Base
  belongs_to :channel
  belongs_to :subchannel
  belongs_to :region
  belongs_to :commune
  belongs_to :workspace
  has_many :zone_managers, dependent: :destroy
  has_many :managers, through: :zone_managers, source: :user
  validates_uniqueness_of [ :commune ], scope: [ :channel, :subchannel, :region ] 
  validates_presence_of :workspace
  accepts_nested_attributes_for :zone_managers, allow_destroy: true


end
