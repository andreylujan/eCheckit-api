# == Schema Information
#
# Table name: zone_managers
#
#  id                 :integer          not null, primary key
#  zone_assignment_id :integer
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class ZoneManager < ActiveRecord::Base
  belongs_to :zone_assignment
  belongs_to :user
  validates_uniqueness_of :user, scope: :zone_assignment
end
