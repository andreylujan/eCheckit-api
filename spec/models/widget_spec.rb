# == Schema Information
#
# Table name: widgets
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  structure  :json             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Widget, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
