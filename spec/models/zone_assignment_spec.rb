# == Schema Information
#
# Table name: zone_assignments
#
#  id            :integer          not null, primary key
#  channel_id    :integer
#  subchannel_id :integer
#  region_id     :integer
#  commune_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  workspace_id  :integer          not null
#

require 'rails_helper'

RSpec.describe ZoneAssignment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
