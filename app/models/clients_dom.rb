# == Schema Information
#
# Table name: clients_doms
#
#  id           :integer          not null, primary key
#  workspace_id :integer
#  name         :text
#  rut          :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ClientsDom < ActiveRecord::Base
	belongs_to :workspace
	has_many :works_doms, foreign_key: "client_id", dependent: :destroy
	validates_presence_of [ :name, :workspace ]
end
