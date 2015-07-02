# == Schema Information
#
# Table name: channels
#
#  id           :integer          not null, primary key
#  name         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  image        :text
#  workspace_id :integer
#

class ChannelSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :subchannels
end
