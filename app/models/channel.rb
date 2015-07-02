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

class Channel < ActiveRecord::Base
  belongs_to :workspace
  has_many :subchannels, dependent: :destroy

  accepts_nested_attributes_for :subchannels, allow_destroy: true
end
