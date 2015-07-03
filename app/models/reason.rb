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
#

class Reason < ActiveRecord::Base
  belongs_to :workspace

  belongs_to :workspace
  has_many :reports
  validates_presence_of  :name
  validates_presence_of  :workspace
  validates_uniqueness_of :name, scope: :workspace_id
end
