class ClientsDomSerializer < ActiveModel::Serializer
  attributes :id, :workspace_id, :name, :rut
end
