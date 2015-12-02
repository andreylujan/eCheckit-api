# == Schema Information
#
# Table name: constructions
#
#  id         :integer          not null, primary key
#  client_id  :integer
#  name       :text             not null
#  address    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  unique_id  :integer          not null
#

class Construction < ActiveRecord::Base
	belongs_to :client
	has_many :contacts, foreign_key: "work_id", dependent: :destroy
	validates_presence_of [ :name, :client ]
end
