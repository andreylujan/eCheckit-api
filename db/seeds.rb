# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

org = Organization.create(name: "Koandina")
Doorkeeper::Application.create name: "echeckit", redirect_uri: "https://127.0.0.1"
user = User.create(email: "demo@ewin.cl", password: "12345678", first_name: "Juan", last_name: "Pérez", rut: "111111111")
assignee = User.create(email: "alujan@ewin.cl", password: "12345678")
action_type = ActionType.create(description: "Cobrar", organization: org)
report = Report.create(creator: user, assigned_user: assignee)
Action.create(action_type: action_type, user: user, report: report)
