# == Schema Information
#
# Table name: reasons
#
#  id           :integer          not null, primary key
#  workspace_id :integer
#  name         :text             not null
#  image        :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  deleted_at   :datetime
#

class ReasonSerializer < ActiveModel::Serializer
  attributes :id, :name, :image
end
