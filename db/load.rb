problems = []

f = File.open("./db/responsables_moderno.csv", "r")
workspace = Workspace.first
f.each_line do |line|
	data = line.split(';')
	channel_name = data[0].downcase
	subchannel_name = data[1].downcase
	address = data[2].downcase
	commune_name = I18n.transliterate(data[4]).downcase
	manager = data[5]
	indirect_manager = data[7]
	region_name = data[3]

	channel = Channel.find_by_organization_id_and_name(1, channel_name)

	if channel.nil?
		puts "Creating channel #{channel_name}"
		channel = Channel.create organization_id: 1, name: channel_name
	end
	subchannel = Subchannel.find_by_channel_id_and_name channel.id, subchannel_name
	if subchannel.nil?
		puts "Creating subchannel #{subchannel_name}"
		subchannel = Subchannel.create channel_id: channel.id, name: subchannel_name
	end
	user = User.find_by_first_name manager
	if user.nil? and manager.present?
		puts "Creating user #{manager}"
		email = I18n.transliterate(manager.split(' ').join().downcase) + "@koandina.cl"
		user = User.create email: email, password: "12345678", password_confirmation: "12345678",
		first_name: manager
		user.add_role :user, workspace
		WorkspaceInvitation.create workspace: workspace, accepted: true, user_id: user.id
	end

	region = Region.find_by_roman_numeral(region_name)
	if region.nil?
		puts "Region #{region_name} does not exist"
	else
		commune = region.communes.where("lower(unaccent(name)) = ?", commune_name).first
		if commune.nil?
			puts "Commune #{commune_name} does not exist"
			problems << "#{region_name} - #{commune_name}"
		elsif user.present?
			za = ZoneAssignment.find_or_create_by channel: channel, subchannel: subchannel, region: region,
			commune: commune, workspace_id: 1
			ZoneManager.find_or_create_by user: user, zone_assignment: za
		end
	end

end
f.close


f = File.open("./db/responsables_tradicional.csv", "r")
workspace = Workspace.first
f.each_line do |line|
	data = line.split(';')
	channel_name = data[0].downcase
	subchannel_name = data[1].downcase
	manager = data[5]
	region_name = data[3]
	channel = Channel.find_by_organization_id_and_name(1, channel_name)
	commune_name = I18n.transliterate(data[4]).downcase

	if channel.nil?
		puts "Creating channel #{channel_name}"
		channel = Channel.create organization_id: 1, name: channel_name
	end
	subchannel = Subchannel.find_by_channel_id_and_name channel.id, subchannel_name
	if subchannel.nil?
		puts "Creating subchannel #{subchannel_name}"
		subchannel = Subchannel.create channel_id: channel.id, name: subchannel_name
	end
	user = User.find_by_first_name manager
	if user.nil? and manager.present?
		puts "Creating user #{manager}"
		email = I18n.transliterate(manager.split(' ').join().downcase) + "@koandina.cl"
		user = User.create email: email, password: "12345678", password_confirmation: "12345678",
		first_name: manager
		user.add_role :user, workspace
		WorkspaceInvitation.create workspace: workspace, accepted: true, user_id: user.id
	end
	
	region = Region.find_by_roman_numeral(region_name)
	if region.nil?
		puts "Region #{region_name} does not exist"
		byebug
		a = 2
	else
		commune = region.communes.where("lower(unaccent(name)) = ?", commune_name).first
		if commune.nil?
			puts "Commune #{commune_name} does not exist"
			problems << "#{region_name} - #{commune_name}"
		elsif user.present?
			za = ZoneAssignment.find_or_create_by channel: channel, subchannel: subchannel, region: region,
			commune: commune, workspace_id: 1
			ZoneManager.find_or_create_by user: user, zone_assignment: za
		end
	end


end
f.close

ap problems.uniq