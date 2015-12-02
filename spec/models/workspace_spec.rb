# == Schema Information
#
# Table name: workspaces
#
#  id              :integer          not null, primary key
#  name            :text
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  is_open         :boolean          default(TRUE), not null
#  email           :text
#  welcome_message :text
#  confirm_message :text
#

require 'rails_helper'

RSpec.describe Workspace, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
