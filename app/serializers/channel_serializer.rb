# == Schema Information
#
# Table name: channels
#
#  id              :integer          not null, primary key
#  name            :text
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ChannelSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :subchannels
end
