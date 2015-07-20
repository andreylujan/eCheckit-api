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

class Reason < ActiveRecord::Base
	acts_as_paranoid
	belongs_to :workspace
	has_many :reports
	validates_presence_of  :name
	validates_presence_of  :workspace
	validate :unique_name
	def unique_name
		if Reason.where(name: self.name, workspace_id: self.workspace_id).count > 0
			errors.add(:name, "ya está en uso")
		end
	end

end
