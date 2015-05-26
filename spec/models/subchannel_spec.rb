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

require 'rails_helper'

RSpec.describe Subchannel, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
