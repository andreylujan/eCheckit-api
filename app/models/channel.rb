# == Schema Information
#
# Table name: channels
#
#  id           :integer          not null, primary key
#  name         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  image        :text
#  workspace_id :integer
#  deleted_at   :datetime
#

class Channel < ActiveRecord::Base

  acts_as_paranoid
  belongs_to :workspace
  has_many :subchannels, dependent: :destroy
  has_many :zone_assignments, dependent: :destroy
  has_many :reports, dependent: :nullify
  validates_uniqueness_of :name, scope: :workspace_id
  accepts_nested_attributes_for :subchannels, allow_destroy: true
end
