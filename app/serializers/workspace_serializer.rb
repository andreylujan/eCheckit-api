# == Schema Information
#
# Table name: workspaces
#
#  id              :integer          not null, primary key
#  name            :text
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class WorkspaceSerializer < ActiveModel::Serializer
  attributes :id, :name, :organization_id, :reports
  
  def reports
    object.reports.order('created_at desc')
  end
end
