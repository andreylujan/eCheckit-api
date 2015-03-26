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

class Contact < ActiveRecord::Base
  belongs_to :venue
end
