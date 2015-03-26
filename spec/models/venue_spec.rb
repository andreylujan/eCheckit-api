# == Schema Information
#
# Table name: venues
#
#  id              :integer          not null, primary key
#  organization_id :integer
#  description     :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe Venue, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
