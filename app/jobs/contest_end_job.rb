class ContestEndJob < ActiveJob::Base
	queue_as :default

	def perform(contest_id, message)
		contest = Contest.find(contest_id)
		apns_app_name = "embajadores_ios_development"
		gcm_app_name = "embajadores_android"
		contest.workspace.registered_users.each do |user|

			devices = user.devices
			conn = Faraday.new(:url => ENV["PUSH_ENGINE_HOST"])
			params = {
				alert: "#{message}",
				data: {
					message: "#{message}",
					title: "Concurso",
					type: "contest"
					},
					gcm_app_name: gcm_app_name,
					apns_app_name: apns_app_name
				}
				devices.each do |device|
					if device.name == "android"
						body = params.merge({ registration_id: device.registration_id })
					else
						body = params.merge({ device_token: device.device_token })
					end
					response = conn.post do |req|
						req.url '/notifications'
						req.headers['Content-Type'] = 'application/json'
						req.body = body.to_json
					end

				end
			end

		end
	end


