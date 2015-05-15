# == Schema Information
#
# Table name: actions
#
#  id             :integer          not null, primary key
#  action_type_id :integer
#  user_id        :integer
#  report_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  data           :json
#

require 'rails_helper'

RSpec.describe Action, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
