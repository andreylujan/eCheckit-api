class ContactDom < ActiveRecord::Base
	belongs_to :works_dom, foreign_key: "work_id"
	validates_presence_of [ :name, :work_dom ]
end
