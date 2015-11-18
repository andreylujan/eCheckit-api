# == Schema Information
#
# Table name: works_doms
#
#  id         :integer          not null, primary key
#  client_id  :integer
#  name       :text
#  address    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class WorksDom < ActiveRecord::Base
	belongs_to :clients_dom
	has_many :contact_doms, foreign_key: "work_id", dependent: :destroy
	validates_presence_of [ :name, :clients_dom ]
	validates_uniqueness_of :name, scope: :client_id
end
