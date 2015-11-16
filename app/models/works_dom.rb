class WorksDom < ActiveRecord::Base
	belongs_to :clients_dom
	has_many :contact_doms, foreign_key: "work_id", dependent: :destroy
	validates_presence_of [ :name, :clients_dom ]
end
