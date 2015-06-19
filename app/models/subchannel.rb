# == Schema Information
#
# Table name: subchannels
#
#  id         :integer          not null, primary key
#  channel_id :integer
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Subchannel < ActiveRecord::Base
  belongs_to :channel
  has_many :zone_assignments
end
