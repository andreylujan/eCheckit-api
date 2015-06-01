class ZoneAssignmentSerializer < ActiveModel::Serializer
	attributes :id, :channel, :subchannel, :region, :commune

	def managers
		m = []
		object.managers.each do |manager|
			m << manager.name
		end
		m
	end

	def channel
		if object.channel
			object.channel.name
		end
	end

	def subchannel
		if object.subchannel
			object.subchannel.name
		end
	end

	def region
		if object.region
			object.region.name
		end
	end

	def commune
		if object.commune
			object.commune.name
		end
	end
end
