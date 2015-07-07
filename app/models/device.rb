# == Schema Information
#
# Table name: devices
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  device_token    :text
#  registration_id :text
#  uuid            :text
#  architecture    :text
#  address         :text
#  locale          :text
#  manufacturer    :text
#  model           :text
#  name            :text
#  os_name         :text
#  processor_count :integer
#  version         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Device < ActiveRecord::Base
  belongs_to :user

  validate :token_existence
  validates_uniqueness_of :device_token, allow_nil: true
  validates_uniqueness_of :registration_id, allow_nil: true
  validates_uniqueness_of :uuid, allow_nil: true

  private
  def token_existence
  	if device_token.nil? and registration_id.nil?
  		errors.add(:device_token, "Device token and registration id cannot be both null")
  		errors.add(:registration_id, "Device token and registration id cannot be both null")
  	end
  end
end
