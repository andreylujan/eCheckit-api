# == Schema Information
#
# Table name: channels
#
#  id              :integer          not null, primary key
#  name            :text
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  image           :text
#  workspace_id    :integer
#

class Channel < ActiveRecord::Base
  belongs_to :organization
  has_many :subchannels

  accepts_nested_attributes_for :subchannels, allow_destroy: true
end
