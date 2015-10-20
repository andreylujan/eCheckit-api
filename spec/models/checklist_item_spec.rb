# == Schema Information
#
# Table name: checklist_items
#
#  id                    :integer          not null, primary key
#  checklist_category_id :integer
#  name                  :text             not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'rails_helper'

RSpec.describe ChecklistItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
