# == Schema Information
#
# Table name: action_types
#
#  id              :integer          not null, primary key
#  description     :text
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe ActionType, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
