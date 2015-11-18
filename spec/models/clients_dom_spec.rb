# == Schema Information
#
# Table name: clients_doms
#
#  id           :integer          not null, primary key
#  workspace_id :integer
#  name         :text
#  rut          :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe ClientsDom, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
