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

class Subchannel < ActiveRecord::Base
  belongs_to :channel
  belongs_to :direct_manager, foreign_key: :direct_manager_id, class_name: :User
  belongs_to :indirect_manager, foreign_key: :indirect_manager_id, class_name: :User
end
