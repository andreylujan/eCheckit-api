# == Schema Information
#
# Table name: checklist_items
#
#  id                    :integer          not null, primary key
#  checklist_category_id :integer
#  name                  :text             not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class ChecklistItem < ActiveRecord::Base
  belongs_to :checklist_category
  validates_presence_of [ :name, :checklist_category ]
  validates_uniqueness_of :name, scope: :checklist_category_id
  before_save :capitalize_name
  
  private
  def capitalize_name
        self.name = self.name.capitalize
  end
end
