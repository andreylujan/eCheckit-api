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
#  deleted_at   :datetime
#

class ChannelSerializer < ActiveModel::Serializer
  attributes :id, :name, :image
  has_many :subchannels
end
