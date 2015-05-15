

class WorkspaceUserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :name

  def accepted
  end

  def pending
  end


end
