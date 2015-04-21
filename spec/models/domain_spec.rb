# == Schema Information
#
# Table name: domains
#
#  id                           :integer          not null, primary key
#  organization_id              :integer
#  domain                       :text             not null
#  default_email                :text             not null
#  allow_automatic_registration :boolean          default(TRUE), not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#

require 'rails_helper'

RSpec.describe Domain, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
