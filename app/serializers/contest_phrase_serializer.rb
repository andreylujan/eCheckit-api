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

class ContestPhraseSerializer < ActiveModel::Serializer
  attributes :id, :phrase, :tier
end
