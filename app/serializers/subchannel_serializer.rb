# == Schema Information
#
# Table name: subchannels
#
#  id                  :integer          not null, primary key
#  channel_id          :integer
#  name                :text
#  direct_manager_id   :integer
#  indirect_manager_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class SubchannelSerializer < ActiveModel::Serializer
  attributes :id, :name, :direct_manager_id, :indirect_manager_id
  has_one :channel
end
