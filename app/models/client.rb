# == Schema Information
#
# Table name: clients
#
#  id           :integer          not null, primary key
#  workspace_id :integer
#  name         :text             not null
#  rut          :text             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Client < ActiveRecord::Base
	belongs_to :workspace
	has_many :constructions, foreign_key: "client_id", dependent: :destroy
	validates_presence_of [ :name, :workspace, :rut ]

    before_validation :upcase_rut
    private
    def upcase_rut
        self.rut = self.rut.upcase if self.rut.present?
    end
end
