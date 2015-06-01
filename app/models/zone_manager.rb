class ZoneManager < ActiveRecord::Base
  belongs_to :zone_assignment
  belongs_to :user
  validates_uniqueness_of :user, scope: :zone_assignment
end
