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

class Channel < ActiveRecord::Base
  belongs_to :organization
  has_many :subchannels
end