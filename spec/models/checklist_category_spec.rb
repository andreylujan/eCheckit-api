# == Schema Information
#
# Table name: checklist_categories
#
#  id           :integer          not null, primary key
#  name         :text             not null
#  checklist_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe ChecklistCategory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
