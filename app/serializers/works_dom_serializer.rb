class WorksDomSerializer < ActiveModel::Serializer
  attributes :id, :client_rut, :name, :address
end
