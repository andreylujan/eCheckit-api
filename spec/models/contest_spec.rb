# == Schema Information
#
# Table name: contests
#
#  id           :integer          not null, primary key
#  workspace_id :integer
#  starts_at    :datetime
#  ends_at      :datetime
#  prize        :text
#  tier_steps   :float            default([0.33, 0.66]), not null, is an Array
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Contest, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
