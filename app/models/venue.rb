# == Schema Information
#
# Table name: venues
#
#  id              :integer          not null, primary key
#  organization_id :integer
#  description     :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Venue < ActiveRecord::Base
  belongs_to :organization
  has_many :contacts
  has_many :reports
end
