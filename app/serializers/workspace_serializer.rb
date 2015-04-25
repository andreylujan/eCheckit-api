# == Schema Information
#
# Table name: workspaces
#
#  id              :integer          not null, primary key
#  name            :text
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  is_open         :boolean          default(TRUE), not null
#

class WorkspaceSerializer < ActiveModel::Serializer
  attributes :id, :name, :organization_id
  
  has_many :reports
  has_many :report_field_types
  
  def reports
    object.reports.order('created_at desc')
  end
end
