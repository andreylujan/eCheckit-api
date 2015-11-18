# == Schema Information
#
# Table name: works_doms
#
#  id         :integer          not null, primary key
#  client_id  :integer
#  name       :text
#  address    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe WorksDom, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
