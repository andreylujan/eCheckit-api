# == Schema Information
#
# Table name: contact_doms
#
#  id         :integer          not null, primary key
#  work_id    :integer
#  name       :text
#  email      :text
#  phone      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe ContactDom, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
