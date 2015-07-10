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
  has_many :zone_assignments, dependent: :destroy
  has_many :reports, dependent: :nullify
  validates_uniqueness_of :name, scope: :channel_id
end
