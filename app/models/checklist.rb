# == Schema Information
#
# Table name: checklists
#
#  id           :integer          not null, primary key
#  name         :text             not null
#  workspace_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Checklist < ActiveRecord::Base
  belongs_to :workspace
  validates_presence_of [ :name, :workspace ]
  validates_uniqueness_of :name, scope: :workspace_id
end
