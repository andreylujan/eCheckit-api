class WorksDomSerializer < ActiveModel::Serializer
  attributes :id, :client_id, :name, :address
end
