# == Schema Information
#
# Table name: checklist_categories
#
#  id           :integer          not null, primary key
#  name         :text             not null
#  checklist_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ChecklistCategory < ActiveRecord::Base
  belongs_to :checklist
  validates_presence_of [ :name, :checklist ]
  validates_uniqueness_of :name, scope: :checklist_id
end
