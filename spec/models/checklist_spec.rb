# == Schema Information
#
# Table name: checklists
#
#  id           :integer          not null, primary key
#  name         :text             not null
#  workspace_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  image        :text
#

require 'rails_helper'

RSpec.describe Checklist, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end