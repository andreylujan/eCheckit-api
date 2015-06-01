# == Schema Information
#
# Table name: zone_assignments
#
#  id            :integer          not null, primary key
#  channel_id    :integer
#  subchannel_id :integer
#  region_id     :integer
#  commune_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  workspace_id  :integer          not null
#

class ZoneAssignmentSerializer < ActiveModel::Serializer
	attributes :id, :managers, :region
	has_one :channel
	has_one :subchannel
	has_one :commune

	def managers
		m = []
		object.managers.each do |manager|
			m << {
				name: manager.name,
				id: manager.id
			}
		end
		m
	end

	def region
		r = object.region
		if r.present?
			{
				id: r.id,
				name: r.name,
				number: r.number,
				roman_numeral: r.roman_numeral
			}
		end
	end
end
