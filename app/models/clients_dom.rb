class ClientsDom < ActiveRecord::Base
	belongs_to :workspace
	has_many :works_doms, foreign_key: "client_id", dependent: :destroy
	validates_presence_of [ :name, :workspace ]
	validates_uniqueness_of :name, scope: :workspace_id
end
