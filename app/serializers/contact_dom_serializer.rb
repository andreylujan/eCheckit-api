# == Schema Information
#
# Table name: contact_doms
#
#  id         :integer          not null, primary key
#  work_id    :integer
#  name       :text
#  email      :text
#  phone      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ContactDomSerializer < ActiveModel::Serializer
  attributes :id, :work_id, :name, :email, :phone
end
