# == Schema Information
#
# Table name: contest_phrases
#
#  id              :integer          not null, primary key
#  organization_id :integer
#  tier            :integer          not null
#  phrase          :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe ContestPhrase, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
