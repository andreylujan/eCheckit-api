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
    acts_as_paranoid
	has_many :contacts, dependent: :destroy
	validates_presence_of [ :name, :client ]
end
