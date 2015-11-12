class ContactDomSerializer < ActiveModel::Serializer
  attributes :id, :work_id, :name, :email, :phone
end
