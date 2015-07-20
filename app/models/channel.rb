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
  accepts_nested_attributes_for :subchannels, allow_destroy: true
  validate :unique_name

  def unique_name
  	if Channel.where(name: self.name, workspace_id: self.workspace_id).count > 0
  		errors.add(:name, "ya está en uso")
  	end
  end
end
