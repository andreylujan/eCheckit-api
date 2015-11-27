# == Schema Information
#
# Table name: works_doms
#
#  id         :integer          not null, primary key
#  client_id  :integer
#  name       :text
#  address    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class WorksDomSerializer < ActiveModel::Serializer
  attributes :id, :client_rut, :name, :address
end
