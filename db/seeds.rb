# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Doorkeeper::Application.create name: "echeckit", redirect_uri: "https://127.0.0.1"

org = Organization.create(name: "Koandina")
w = Workspace.create organization: org, name: "Embajadores"

user = User.create(email: "demo@ewin.cl", password: "12345678", first_name: "Juan", last_name: "Pérez", rut: "111111111")
assignee = User.create(email: "alujan@ewin.cl", password: "12345678", first_name: "Andrey", last_name: "Lujan",
	rut: "27835805")
user.add_role :user, w
assignee.add_role :user, w

created = ReportState.create workspace: w, name: "Creado"
assigned = ReportState.create workspace: w, name: "Asignado"

action_type = ActionType.create(description: "Cobrar", organization: org)

report = Report.create(creator: user, assigned_user: assignee, title: "Local Matta", report_state: assigned)
report = Report.create(creator: user, assigned_user: assignee, title: "Local Vicuña", report_state: assigned)
report = Report.create(creator: user, assigned_user: assignee, title: "Easy", report_state: assigned)

# Action.create(action_type: action_type, user: user, report: report)

