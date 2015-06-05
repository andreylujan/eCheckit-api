f = File.open("./db/users/beta", "r")

f.each_line do |line|
	data = line.split(',')
	name = data[0].strip
	email = data[1].strip.downcase	
	name_parts = name.split(' ')
	if name_parts.length == 3
		first_name = name_parts[0] + " " + name_parts[1]
		last_name = name_parts[2]
	else
		first_name = name_parts[0]
		last_name = name_parts[1]
	end

	u = User.find_by_email(email)
	if u.nil?
		u = User.create email: email, first_name: first_name, last_name: last_name, password: "12345678"
		WorkspaceInvitation.create user: u, workspace_id: 1, accepted: true, user_email: email
		u.add_role :user, Workspace.first
	end
end

f.close
