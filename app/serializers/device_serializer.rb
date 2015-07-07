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

class DeviceSerializer < ActiveModel::Serializer
  attributes :id, :device_token, :registration_id, :uuid, :architecture, :address, :locale, :manufacturer, :model, :name, :os_name, :processor_count, :version,
  	:user_id
end
