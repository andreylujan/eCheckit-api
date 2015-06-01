# == Schema Information
#
# Table name: zone_managers
#
#  id                 :integer          not null, primary key
#  zone_assignment_id :integer
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe ZoneManager, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
