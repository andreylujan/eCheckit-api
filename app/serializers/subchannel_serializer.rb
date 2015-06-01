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

class SubchannelSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :channel
end
