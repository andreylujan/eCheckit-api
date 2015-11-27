# == Schema Information
#
# Table name: clients_doms
#
#  id           :integer          not null, primary key
#  workspace_id :integer
#  name         :text
#  rut          :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ClientsDomSerializer < ActiveModel::Serializer
  attributes :id, :workspace_id, :name, :rut
end
