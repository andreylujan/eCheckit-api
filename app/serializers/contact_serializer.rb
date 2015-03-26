# == Schema Information
#
# Table name: contacts
#
#  id           :integer          not null, primary key
#  description  :text
#  phone_number :text
#  venue_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ContactSerializer < ActiveModel::Serializer
  attributes :id, :description, :phone_number
  has_one :venue
end
