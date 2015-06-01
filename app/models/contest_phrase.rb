# == Schema Information
#
# Table name: contest_phrases
#
#  id              :integer          not null, primary key
#  organization_id :integer
#  tier            :integer          not null
#  phrase          :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ContestPhrase < ActiveRecord::Base
  belongs_to :organization
end
