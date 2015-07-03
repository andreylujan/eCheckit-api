# == Schema Information
#
# Table name: reasons
#
#  id           :integer          not null, primary key
#  workspace_id :integer
#  name         :text             not null
#  image        :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Reason, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
