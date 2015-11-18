# == Schema Information
#
# Table name: contact_doms
#
#  id         :integer          not null, primary key
#  work_id    :integer
#  name       :text
#  email      :text
#  phone      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ContactDom < ActiveRecord::Base
	belongs_to :works_dom, foreign_key: "work_id"
	validates_presence_of [ :name, :work_dom ]
	validates_uniqueness_of :name, scope: :work_id
end
