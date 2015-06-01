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
  attributes :id, :name, :organization_id, :users
  
  has_many :reports
  has_many :report_field_types
  has_many :report_states
  has_many :contests
  
  def reports
  	object_reports = object.reports.order('created_at desc')
  	reports_json = []
    object_reports.each do |report|
    	reports_json << ReportIndexSerializer.new(report).as_json
    end
  	reports_json
  end
end
