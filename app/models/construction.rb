# == Schema Information
#
# Table name: constructions
#
#  id         :integer          not null, primary key
#  client_id  :integer
#  name       :text
#  address    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Construction < ActiveRecord::Base
	belongs_to :client
	has_many :contacts, foreign_key: "work_id", dependent: :destroy
	validates_presence_of [ :name, :clients_dom ]
end
