# == Schema Information
#
# Table name: communes
#
#  id         :integer          not null, primary key
#  region_id  :integer          not null
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Commune, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
