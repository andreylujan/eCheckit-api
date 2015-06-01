class ZoneManager < ActiveRecord::Base
  belongs_to :zone_assignment
  belongs_to :user
end
