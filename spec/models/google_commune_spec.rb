# == Schema Information
#
# Table name: google_communes
#
#  id             :integer          not null, primary key
#  commune        :text
#  google_commune :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe GoogleCommune, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
