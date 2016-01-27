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

  def send_test_push

    apns_app_name = ENV["APNS_APP_NAME"]
    gcm_app_name = ENV["GCM_APP_NAME"]

    conn = Faraday.new(:url => ENV["PUSH_ENGINE_HOST"])
    params = {
      alert: "Test alert",
      data: {
        message: "Test Message",
        title: "Test title",
        report_id: 763,
        type: "assign"
      },
      gcm_app_name: gcm_app_name,
      apns_app_name: apns_app_name
    }

    if self.name == "android"
      body = params.merge({ registration_id: self.registration_id })
    else
      body = params.merge({ device_token: self.device_token })
    end
    response = conn.post do |req|
      req.url '/notifications'
      req.headers['Content-Type'] = 'application/json'
      req.body = body.to_json
    end

  end

  private
  def token_existence
    if device_token.nil? and registration_id.nil?
      errors.add(:device_token, "Device token and registration id cannot be both null")
      errors.add(:registration_id, "Device token and registration id cannot be both null")
    end
  end


end
